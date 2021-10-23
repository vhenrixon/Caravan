//
//  SearchBar.swift
//  Caravan
//
//  Created by Srikar  Balusu on 10/23/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            TextField("Search destination ...", text: $text)
                .padding(.leading, 7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray4))
                .cornerRadius(8)
                .overlay( HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)})
                .padding(.horizontal, 10).frame(width: 375,alignment: .leading)
                .offset(x: -10, y: -15)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13")
        }
        }
}
