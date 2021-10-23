//
//  Database.swift
//  Caravan
//
//  Created by Victor Henriksson on 10/23/21.
//

import Foundation
import Firebase


class Database {
    
    @Published var db: Firestore;
    @Published var countryList = [ActiveCountries]()
    var docRef: DocumentReference!

    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    @Published var tripData = [ActiveCountries]()
    
    
    func getRef() -> DocumentReference {
        return Firestore.firestore().collection("Users").document("Martha")
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

    func downloadDocument() {
        
    }
}

struct Trip: Identifiable, Hashable{
    var date: String;
    var amountOfPeople: Int;
    var id: String;

    init(date:String, amountOfPeople:Int, id:String) {
        self.date = date;
        self.amountOfPeople = amountOfPeople;
        self.id = id;
    }

    func getDate() -> String{
        return self.date;
    }
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        return lhs.id == rhs.id;
    }
}






struct Country: Identifiable, Hashable{

    var id: String;
    var tripCollection: [Trip];

    init(tripCollection: [Trip], id: String) {
        self.tripCollection = tripCollection;
        self.id = id;
    }
    init(id:String) {
        self.id = id;
        self.tripCollection = [];
    }

    func getTrip() -> [Trip] {
        return self.tripCollection;
    }
    /*
    func addTrip(trip:Trip) {
        tripCollection.append(contentsOf: trip);
    }
     */

    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id;
    }


}
struct ActiveCountries: Identifiable{
    var id: String;
    var countriesCollection: [Country];
  
    init(countriesCollection: [Country], id: String) {
        self.countriesCollection = countriesCollection;
        self.id = id;
    }
    

}
struct User: Identifiable{
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
