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
    @State var text = ""
    var body: some View {
        NavigationView {
            VStack {
            SearchBar(text: $text)
                Text("TRAVEL THE WORLD").font(.custom("Helvetica", size: 25)).foregroundColor(Color.black).bold()/*.overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: 4))*/
                    .offset(x: -55, y: 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                ForEach(international_travels){Travel in
                    NavigationLink(destination: CountryPageView()){
                    Image(Travel.image).resizable().cornerRadius(10).frame(width: 250, height: 225, alignment: .center).overlay(ImageOverlay(text: Travel.destination), alignment: .topLeading)
                        .offset(x: 10, y: 0)}
                }
            }
        }
                Text("EXPLORE USA").font(.custom("Helvetica", size: 25)).foregroundColor(Color.black).bold()/*.overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: 4))*/
                    .offset(x: -95, y: 5)
                ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20){
                    ForEach(usa_travels){Travel in
                        NavigationLink(destination: CountryPageView()){
                        Image(Travel.image).resizable().cornerRadius(10).frame(width: 250, height: 225, alignment: .center).overlay(ImageOverlay(text: Travel.destination), alignment: .topLeading)
                            .offset(x: 10, y: 0)}
                    }
                }
            }
            }
        }
    }
}
