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
    
    func downloadDocument() {
        docRef = db.document("Countries/Trips")
        docRef.getDocument { (docSnapshot, error) in
            if (error != nil) {
                print("An Error When Downloading")
            }
            let json = try? JSONSerialization.jsonObject(with: docSnapshot.data()!, options: [])
            guard let dictionary = json as? [String: Any]
            else {
                print("Retrieve data error.")
                return
            }
            decodeData(decodeData: dictionary)
        }
    }
    
    func decodeData(decodeData: Dictionary<String: Any> ) {
        //decode jason response from FriendListResponse format in FriendFormat.swift
            do {
                let decoder = JSONDecoder()
                let countryData = try decoder.decode(ActiveCountries.self, from: decodeData!)
                
                DispatchQueue.main.async {
                    self.countryList = countryData.countriesCollection
                    print("Countries are: ", self.countryList)
                }
            } catch let error as NSError {
                print("Error in JSON parsing")
                print(error.debugDescription)
            }
    }
}

struct Trip: Identifiable, Codable {
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



struct Country: Identifiable, Codable {
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
    var countriesCollection: <Country>;
    init(countriesCollection: <Country>, id: String) {
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


