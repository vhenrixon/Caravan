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
    
    
    /**
     func uploadDocument() {

        docRef = db.document("Countries")
        docRef.setData(data) { error in
            if error != nil {
                print("An Error Occured!")
            } else {
                print("Data Save Successfully")
            }
        }
    }
     */

    /*
    func downloadDocument() {
        self.db.collection("Countries").getDocuments() {
            (docSnapshot, error) in
                if (error != nil) {
                    print("An Error When Downloading")
                } else {
                    var actives: [Country] = []
                    for country in docSnapshot!.documents {
                        var tempCountry = Country(id: country.documentID);
                        self.db.collection("Countries").document(country.documentID).getDocument {
                            (docCountrySnapshot, error) in
                            if(error != nil) {
                                print("An error when Downloading");
                            } else {
                                print(docCountrySnapshot!.data()["Date"])
                                /*
                                for trip in docCountrySnapshot!.data(){
                                    /*
                                    var tempTrip = Trip(date: trip.data()["date"], amountOfPeople: trip.data()["amountOfPeople"], id: trip.data()["id"])
                                    tempCountry.addTrip(trip: tempTrip);
                                     */
                                    print(trip.documentID);
                                }*/
                                 
                            }
                            
                        }
                        
                                    
                            
                    }
                }
            
                     
        }
     

    } */
    func getCountries() -> [Country]{
        var countries: [Country] = [];
        self.db.collection("Countries").getDocuments {
            (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        countries.append(Country(id: document.documentID))
                        self.db.collection("Countries").document(document.documentID).collection("Trips").getDocuments{
                            (tripDoc, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for doc in tripDoc!.documents{
                                    print("\(doc.documentID) => \(doc.data())")
                                }
                            }
                        }

                    }
                }

        }
        print(countries);
        return countries;
    }

}
class Trip: Identifiable{
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






class Country: Identifiable{

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
class ActiveCountries: Identifiable{
    var id: String;
    var countriesCollection: [Country];
  
    init(countriesCollection: [Country], id: String) {
        self.countriesCollection = countriesCollection;
        self.id = id;
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


