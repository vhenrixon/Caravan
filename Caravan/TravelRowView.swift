//
//  TravelRowView.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//

import SwiftUI

/*struct ImageOverlay : View {
    var text: String
    var body: some View {
            Text(text).font(.custom("Helvetica", size: 20)).bold().padding(6).foregroundColor(.white)
    }
}*/

struct TravelRowView: View {
    var trav: Travel
    var body: some View {
                Image(trav.image).resizable().cornerRadius(10).frame(width: 250, height: 225, alignment: .center).overlay(ImageOverlay(text: trav.destination), alignment: .topLeading)
                .offset(x: 10, y: 0)
    }
}
