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

    init() {
        FirebaseApp.configure()
        self.db = Firestore.firestore()
    }
    
    @Published var tripData = Set<Country>()
    var docRef: DocumentReference!
    
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
            let myData = docSnapshot.data()
        }
    }
    
}


