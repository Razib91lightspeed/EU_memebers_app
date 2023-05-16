//
//  CountryView.swift
//  EUMembers
//
//  Created by Razib Hasan on 01.05.2023.
//

import SwiftUI

struct CountryView: View {
    @State var country: Country
    
    var body: some View {
        VStack {
            Text(country.name)
                .font(.title)
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            
            Image(country.code.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .border(Color.black, width: 1)
                .padding()
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            
            CountryDetailsView(country: $country)
            
            Button(action: {
                if let wikipediaURL = URL(string: "https://en.m.wikipedia.org/wiki/\(country.name.replacingOccurrences(of: " ", with: "_"))") {
                    UIApplication.shared.open(wikipediaURL)
                }
            }) {
                Text("View More Details on Wikipedia")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .shadow(color: .gray, radius: 3, x: 0, y: 10)
                            .padding(.horizontal, 0)
                    )
            }
            .padding()

        }
        .padding()
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: finland)
    }
}
