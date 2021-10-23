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
    
    
    
    
}


