//
//  CountryPageView.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//

import SwiftUI
 
struct CountryPageView: View {
    var name = "";
    @ObservedObject var db: Database = Database();
    @State var tripName = [];
    @State var tripImage = [];
    @State var tripDate = [];
    @State var tripOrganizer = [];
    @State var tripTravelers = [];
    init(name:String){
        print(name)
        self.name = name;
    }
    func findCountry(name: String)  -> Country{
        // var i in 0 ..< self.db.data.getCountry().count
        for country in self.db.data.getCountry(){
            print("Here")
            var cname = country.getName() as! String;
            if(cname == name) {
                print("HERE")
                //print(country)
                return country
            }
        }
        return Country(id: "NULL", isInternational: false, image: "NULL");
    }
    var body: some View {
        
        ScrollView(.vertical) {
            CardView(image: "chinese_new_year", date: "Jan 30th - Feb. 4th", trip_name: "Chinese New Year Festival Trip 2022", trip_organizer: "Simon Zhong", travellers: "32")
            CardView(image: "great-wall_2", date: "March 18th - March 23rd, 2022", trip_name: "Chinese Architecture Series 2022", trip_organizer:
                        "Zach Ferguson", travellers: "14")
            CardView(image: "china_mountains", date: "May 2nd - May 20th, 2022", trip_name: "Chinese Hiking Expedition 2022", trip_organizer:
                        "Andrew Liu", travellers: "22")
        }
    }
}
 
struct CountryPageView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPageView(name: "China")
    }
}
