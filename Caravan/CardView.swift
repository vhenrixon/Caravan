//
//  CardView.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//


import SwiftUI


struct CardView: View {
   var image: String
   var date: String
   var trip_name: String
   var trip_organizer: String
   var travellers: String
   var body: some View {
   
       VStack {
           Image(image)
               .resizable()
               .aspectRatio(contentMode: .fit)

           HStack {
               VStack(alignment: .leading) {
                   Text(date)
                       .font(.headline)
                       .foregroundColor(.secondary)
                   Text(trip_name)
                       .font(.title)
                       .fontWeight(.black)
                       .foregroundColor(.primary)
                       .lineLimit(3)
                   Text(trip_organizer.uppercased())
                       .font(.caption)
                       .foregroundColor(.secondary)
               }
               Text(travellers)
                   .font(.system(size: 15))
                   .fontWeight(.black)
                   .foregroundColor(.primary)
                   .offset(x: 50, y: -39)
               Image(systemName: "person.3.fill")
                   .offset(x: -19, y: -39)
               .layoutPriority(100)
               Spacer()
           }
           .padding()
       }
       .cornerRadius(10)
       .overlay(
           RoundedRectangle(cornerRadius: 10)
               .stroke(Color(.sRGB, red: 255/255, green: 255/255, blue: 255/255, opacity: 0.1), lineWidth: 1)
       )
       .padding([.top, .horizontal])
   }
   
}
   
   

struct CardView_Previews: PreviewProvider {
   static var previews: some View {
       CardView(image: "chinese_new_year", date: "Jan 30th - Feb. 4th", trip_name: "Chinese New Year Festival Trip 2022", trip_organizer: "Simon Zhong", travellers: "32")
       
   }
}
