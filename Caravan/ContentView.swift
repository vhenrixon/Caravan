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
        self.db.addNewData(country: "Land of Lights", tripID: "A Good Trip", data: ["ultraman": "Seven"])
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
