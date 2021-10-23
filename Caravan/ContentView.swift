//
//  ContentView.swift
//  Caravan
//
//  Created by Bowen Tan on 10/22/21.
//

import SwiftUI
import Firebase



struct ContentView: View {

  
    @State var text = ""
    //@ObservedObject var db: Database = Database();
    
    //@State var countries = [];
    var body: some View {
            
        TabView {
            HomeView(text: text).tabItem{Label("Explore",systemImage:"globe.americas.fill")}
            ProfileView().tabItem{Label("Profile", systemImage: "person")}
        MessageView().tabItem{Label("Messages", systemImage: "message.fill")}
        }.accentColor(.black)
        
    
    

    }
    


    
}

    /*
    var body: some View {
        
        HStack {
            ForEach(0 ..< self.countries.count, id: \.self) {i in
                
                Text(countries[i] as! String)
            }
        }.onReceive(db.$data,perform: {data in
            if(data.getCountry().count > 0) {
                print(data.getCountry())
                for var i in 0..<data.getCountry().count {
                    countries.append((data.getCountry())[i].getName());
                }
            }
        })
        */


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13")
        }
    }
}


