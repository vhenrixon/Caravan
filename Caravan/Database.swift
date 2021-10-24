//
//  Database.swift
//  Caravan
//
//  Created by Victor Henriksson on 10/23/21.
//

import Foundation
import Firebase
import UIKit


class Database: ObservableObject{
    
    @Published var db: Firestore;
    @Published var data: ActiveCountries;
    @Published var dataRecieved = false;
    static var userTrips = "";
    
    var docRef: DocumentReference!

    init() {

     
        if(FirebaseApp.app() == nil){
              FirebaseApp.configure()
          }
          self.db = Firestore.firestore()
          self.data = ActiveCountries(countriesCollection: [], id: "");
          self.getData() { (data) in
              self.data = data;
              self.dataRecieved = true;
          }
        /*self.getUserTrips() { (data) in
            self.userTrips = data;
            
        }*/
        
     

        
    }
    
    func getRef() -> DocumentReference {
        return Firestore.firestore().collection("Users").document("John Doe")
    }
    //dataType: for the newly added data, decide whether it is a new country, tripID, or attributes
    
    func editData(operation: String, ref: DocumentReference, data: [String: Any]) {
        
        switch operation {
        case "update":
            ref.updateData(data) { error in
                if error != nil {
                    print("An Error Occured!")
                } else {
                    print("Data Save Successfully")
                }
            }
        case "addElement":
            for instance in data {
                ref.updateData([instance.key: FieldValue.arrayUnion([instance.value])]) { error in
                    if error != nil {
                        print("An Error Occured!")
                    } else {
                        print("Data Save Successfully")
                    }
                }
            }
        case "removeElement":
                for instance in data {
                    ref.updateData([instance.key: FieldValue.arrayRemove([instance.value])]) { error in
                        if error != nil {
                            print("An Error Occured!")
                        } else {
                            print("Data Save Successfully")
                        }
                    }
                }
        default:
            //can set subcollections even if document does not exist
            ref.setData(data, merge: true) { error in
                if error != nil {
                    print("An Error Occured!")
                } else {
                    print("Data Save Successfully")
                }
            }
        }
    }
    
    func changeArray(deleteElement: Bool, country: String, tripID: String, data: Any) {
        //can set subcollections even if document does not exist
        var ref: DocumentReference!
        self.db.collection("Countries").document(country).collection("Trips").document(tripID).setData(data as! [String : Any]) { error in
            if error != nil {
                print("An Error Occured!")
            } else {
                print("Data Save Successfully")
            }
        }
    }

    
    
   
    

    func getData(completion: @escaping(ActiveCountries) -> ()) {
        self.db.collection("Countries").getDocuments {
            (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var _i = 0;
                    for document in querySnapshot!.documents {
                     
                        //China => [:]
                        let isInternational = document.data()["IsInternational"] as? Bool;
                        let image = document.data()["image"] as? String;
                        self.data.addCountry(country: Country(id: document.documentID, isInternational: isInternational ?? false, image: image ?? "China_Image"));
                        self.db.collection("Countries").document(document.documentID).collection("Trips").getDocuments{
                            (tripDoc, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for doc in tripDoc!.documents{
                                    //Trip1 => ["Date": 10/10/2021]
                                   
                                    let date = doc.data()["date"] as? String;
                                    let amountOfPeople = doc.data()["amountOfPeople"] as? Int
                                    let name = doc.data()["name"] as? String;
                                    let organizer = doc.data()["organizer"] as? String;
                                    let descripition = doc.data()["descripition"] as? String;
                                    let people = doc.data()["people"] as? [String];
                                    let estimatedCost = doc.data()["estimatedCost"] as? Float;
                                    let image = doc.data()["image"] as? String;
                                    let countryName = doc.data()["country"] as? String;
                                    self.data.getCountry()[_i].addTrip(
                                        trip: Trip(date: date ?? "00/00/00",
                                                   amountOfPeople: amountOfPeople ?? 0,
                                                   id: doc.documentID,
                                                   name: name ?? "",
                                                   organizer: organizer ?? "",
                                                   descripition: descripition ?? "" ,
                                                   people: people ?? [""],
                                                   estimatedCost: estimatedCost ?? 0.0,
                                                    image: image ?? "",
                                                   country: countryName ?? "")
                                        )
                             
                                }
                            }
                        }

                    }
                    _i += 1;
                }
            completion(self.data);
        }

    }


}
class Trip: Identifiable{

    var date: String;
    var amountOfPeople: Int;
    var id: String;
    var name: String;
    var organizer: String;
    var descripition: String;
    var people: [String];
    var estimatedCost: Float;
    var image: String;
    var country: String
    init(date:String, amountOfPeople:Int, id:String, name:String, organizer: String, descripition: String, people:[String], estimatedCost: Float, image: String, country: String) {
        self.date = date;
        self.amountOfPeople = amountOfPeople;
        self.id = id;
        self.name = name;
        self.organizer = organizer;
        self.descripition = descripition;
        self.people = people;
        self.estimatedCost = estimatedCost;
        self.image = image;
        self.country = country;
    }

    func getDate() -> String{
        return self.date;
    }

    func getAmountOfPeople() -> Int{
        return self.amountOfPeople;
    }
    func getId() -> String{
        return self.id;
    }
    func getOrganizer() -> String{
        return self.organizer;
    }
    func getDescripition() -> String{
        return self.descripition;
    }
    func getPeople() -> [String]{
        return self.people;
    }
    func getEstimatedCost() -> Float{
        return self.estimatedCost;
    }
    func getName() -> String {
        return self.name;
    }
    func getImage() -> String {
        return self.image;
    }
    func getCountryName() -> String {
        return self.country;
    }
    

    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.id == rhs.id;
    }
}




class Country: Identifiable{

    @Published var id: String;
    var tripCollection: [Trip];
    var isInternational: Bool;
    @Published var image: String;
    init(tripCollection: [Trip], id: String, isInternational: Bool, image: String) {
        self.tripCollection = tripCollection;
        self.id = id;
        self.isInternational = isInternational
        self.image = image
    }
    init(id:String, isInternational: Bool, image: String) {
        self.id = id;
        self.tripCollection = [];
        self.isInternational = isInternational;
        self.image = image;
    }
    init(id:String) {
        self.id = id;
        self.tripCollection = [];
        self.isInternational = false;
        self.image = "China_image"
    }

    func getTrip() -> [Trip] {
        print(self.tripCollection)
        return self.tripCollection;
    }

    func getImage() -> String {
        return self.image; 
    }
    func addTrip(trip:Trip) {
        self.tripCollection.append(trip);
    }
    func getName() -> String{
        return self.id
    }
    func getInternational() -> Bool {
        return isInternational;
    }


    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id;
    }


}
class ActiveCountries: Identifiable{
    var id: String;
    var countriesCollection: [Country];
  
    init(countriesCollection: [Country], id: String) {
        self.countriesCollection = countriesCollection;
        self.id = id;
    }

    public func addCountry(country: Country) {
        self.countriesCollection.append(country);
    }
    public func getCountry() -> [Country] {
        return self.countriesCollection;
    }

    

}
class User: Identifiable{
    var id: String;
    var name: String;
    var Trips: [Trip];
    var age: Int;
    
    
    init(name: String, id: String, Trips: [Trip], age: Int) {
        self.name = name;
        self.id = id;
        self.age = age;
        self.Trips = Trips;
    }
    func getName() -> String {
        return self.name;
    }
    func getAllTrips() -> [Trip] {
        return self.Trips;
    }
    func getTrip(index: Int) -> Trip {
        return self.Trips[index];
    }
    func getAge() -> Int {
        return self.age;
    }
 }


struct UserTrips: Encodable {
    var Trips: [String]
}
