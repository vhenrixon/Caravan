//
//  HomeView.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//

import SwiftUI

struct ImageOverlay : View {
    var text: String
    var body: some View {
        Text(text).font(.custom("Helvetica", size: 30)).bold().padding(6).foregroundColor(.white).opacity(100)
    }
}

struct HomeView: View {
    @State var text = "";
    @ObservedObject var db: Database = Database();
    @State var countriesName = [];
    @State var countriesImage = [];
    @State var countriesInternationalStatus = [];
    // Avoiding a race case, b/c async adding of data
    @State var UcountriesName = [];
    @State var UcountriesImage = [];
    @State var UcountriesInternationalStatus = [];
    
    var body: some View {
        NavigationView{
            VStack {
            SearchBar(text: $text)
            Text("TRAVEL THE WORLD")
                    .font(.custom("Helvetica", size: 25))
                    .foregroundColor(Color.black)
                    .bold()
                    .offset(x: -55, y: 5);
        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    ForEach(0 ..< self.UcountriesName.count, id: \.self) {i in
                        var interStatus = UcountriesInternationalStatus[i] as! Bool;
                        if (interStatus == true) {
                            NavigationLink(destination: CountryPageView()){
                            Image(UcountriesImage[i] as! String)
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 250, height: 225, alignment: .center)
                                    .overlay(ImageOverlay(text: countriesName[i] as! String), alignment: .topLeading)
                                    .offset(x: 10, y: 0)
                            }
                        }
                    }.onReceive(db.$data,perform: {data in
                        if(db.data.getCountry().count > 0) {
                            print(data.getCountry())
                            for var i in 0..<data.getCountry().count {
                                UcountriesName.append((data.getCountry())[i].getName());
                                UcountriesImage.append((data.getCountry())[i].getImage());
                                UcountriesInternationalStatus.append((data.getCountry())[i].getInternational())
                            }
                            print(UcountriesInternationalStatus)
                        }
                    });
                };
            };
            Text("EXPLORE USA").font(.custom("Helvetica", size: 25))
                    .foregroundColor(Color.black)
                    .bold()
                    .offset(x: -95, y: 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    ForEach(0 ..< self.countriesName.count, id: \.self) {i in
                        var interStatus = countriesInternationalStatus[i] as! Bool;
                        if (interStatus == false) {
                            NavigationLink(destination: CountryPageView()){
                                Image(countriesImage[i] as! String)
                                        .resizable()
                                        .cornerRadius(10)
                                        .frame(width: 250, height: 225, alignment: .center)
                                        .overlay(ImageOverlay(text: countriesName[i] as! String), alignment: .topLeading)
                                        .offset(x: 10, y: 0)
                            }
                        }
                    }.onReceive(db.$data,perform: {data in
                        if(db.data.getCountry().count > 0) {
                            print(data.getCountry())
                            for var i in 0..<data.getCountry().count {
                                countriesName.append((data.getCountry())[i].getName());
                                countriesImage.append((data.getCountry())[i].getImage());
                                countriesInternationalStatus.append((data.getCountry())[i].getInternational())
                            }
                            print(countriesInternationalStatus)
                        }
                    });
                }
            }
        }
    }
}
}
