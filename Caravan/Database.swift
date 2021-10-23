//
//  Database.swift
//  Caravan
//
//  Created by Victor Henriksson on 10/23/21.
//

import Foundation
import Firebase


class Database: ObservableObject{
    
    @Published var db: Firestore;
    @Published var data: ActiveCountries;
    @Published var dataRecieved = false;
    var docRef: DocumentReference!

    
    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
        self.data = ActiveCountries(countriesCollection: [], id: "");
        self.getData() { (data) in
            self.data = data;
            self.dataRecieved = true;
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
                                    let date = doc.data()["Date"] as? String;
                                    let amountOfPeople = doc.data()["amountOfPeople"] as? Int
                                    let name = doc.data()["name"] as? String;
                                    let organizer = doc.data()["name"] as? String;
                                    let descripition = doc.data()["descripition"] as? String;
                                    let people = doc.data()["people"] as? [String];
                                    let estimatedCost = doc.data()["estimatedCost"] as? Float;
                                    self.data.getCountry()[_i].addTrip(
                                        trip: Trip(date: date ?? "00/00/00",
                                                   amountOfPeople: amountOfPeople ?? 0,
                                                   id: doc.documentID,
                                                   name: name ?? "",
                                                   organizer: organizer ?? "",
                                                   descripition: descripition ?? "" ,
                                                   people: people ?? [""],
                                                   estimatedCost: estimatedCost ?? 0.0));
                             
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

    init(date:String, amountOfPeople:Int, id:String, name:String, organizer: String, descripition: String, people:[String], estimatedCost: Float) {
        self.date = date;
        self.amountOfPeople = amountOfPeople;
        self.id = id;
        self.name = name;
        self.organizer = organizer;
        self.descripition = descripition;
        self.people = people;
        self.estimatedCost = estimatedCost;
    }

    func getDate() -> String{
        return self.date;
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

    func getTrip() -> [Trip] {
        return self.tripCollection;
    }
    func getImage() -> String {
        return self.image; 
    }
    func addTrip(trip:Trip) {
        tripCollection.append(trip);
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

    init(name: String, id: String) {
        self.name = name;
        self.id = id;
    }
    func getName() -> String {
        return self.name;
    }
 }


