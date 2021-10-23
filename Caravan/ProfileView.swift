//
//  ProfileView.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//

import SwiftUI


struct ProfileView: View {
    var body: some View {
        VStack {
            Text("My Profile").font(.custom("Helvetica", size: 25)).bold().padding(15).foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading)
            ScrollView {
        Image("profile_image").resizable().frame(width:250, height:200).clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
            Text("Name: John Smith").font(.custom("Helvetica", size: 25)).bold().padding(5).foregroundColor(.black).frame(maxWidth: .infinity, alignment: .center)
            Text("Age: 27").font(.custom("Helvetica", size: 25)).bold().foregroundColor(.black).frame(maxWidth: .infinity, alignment: .center)
        }
        }
    }
}
