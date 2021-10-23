//
//  Database.swift
//  Caravan
//
//  Created by Victor Henriksson on 10/23/21.
//

import Foundation
import Firebase

struct Trip: Identifiable{
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
}



struct Country: Identifiable{
    var id: String;
    var tripCollection: [Trip];
    
    init(tripCollection: [Trip], id: String) {
        self.tripCollection = tripCollection;
        self.id = id;
    }
    
    func getTrip() -> [Trip] {
        return self.tripCollection;
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

class Database {
    
    @Published var db: Firestore;
    public var countryTest: [Trip] = [Trip(date: "5/5/2021", amountOfPeople: 8, id: "sdsgsg"), Trip(date: "10/21/2021", amountOfPeople: 6, id: "62352362djjsdf")];
    
    init() {
        FirebaseApp.configure()
        //  https://betterprogramming.pub/how-to-use-firebase-in-swiftuis-new-application-lifecycle-c77a8a306d63
        self.db = Firestore.firestore()
    }
    
    
    
    
    
}


