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
    }
    var body: some View {
        Text("Hello, Bruce!")
            .padding()
        ForEach(self.db.countryTest) { i in
            Text(i.getDate());
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
