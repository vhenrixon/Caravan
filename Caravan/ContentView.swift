//
//  ContentView.swift
//  Caravan
//
//  Created by Bowen Tan on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    public var db: Database;
    
    init() {
        self.db = Database();
        var aref = self.db.getRef()
        self.db.editData(operation: "update", ref: aref, data: ["estimatedcost": 50.0])
        
        self.db.downloadDocument();
    }
    var body: some View {
        Text("Hello, Bruce!")
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
