//
//  ContentView.swift
//  EUMembers
//
//  Created by Razib Hasan on 01.05.2023.
//

import SwiftUI

// Define the main view for the app
struct ContentView: View {
    
    // Get the list of countries from the country manager object
    @EnvironmentObject var manager: CountryManager
    
    // Define the body of the view
    var body: some View {
        NavigationView {
            // Display a list of countries in two sections: current members and past members
            List {
                Section(header: Text("Current Members")) {
                    // Iterate through the countries and display each current member
                    ForEach(manager.countries) { country in
                        if country.isMember {
                            Custom_Row_View(country: country)
                        }
                    }
                }
                
                Section(header: Text("Past Members")) {
                    // Iterate through the countries and display each past member
                    ForEach(manager.countries) { country in
                        if !country.isMember {
                            Custom_Row_View(country: country)
                        }
                    }
                }
            }
            // Set the style of the list and the title of the navigation view
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("EU Members")
            
        }
    }
}

struct Custom_Row_View: View {
    
    var country: Country
    
    var body: some View {
        NavigationLink(destination: CountryView(country: country)) {
            HStack {
                flagImage(country: country) // Display the country flag
                    .shadow(color: .gray, radius: 3, x: 0, y: 2) //3d shadow
                    
                Text(country.name) // Display the country name
                    .shadow(color: .gray, radius: 3, x: 0, y: 2)
                    
                Spacer()
                
                starIcon(country: country) // Display the EU membership icon
                    
                euroIcon(country: country) // Display the Euro use icon
                    
                schengenIcon(country: country) // Display the Schengen Area membership icon
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 3, x: 0, y: 2)
        }
    }
    
    private func flagImage(country: Country) -> some View {
        // Display the country flag
        Image(country.code.lowercased())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 20)
    }

    private func starIcon(country: Country) -> some View {
        // Display the EU membership icon
        Image(systemName: country.isMember ? "star.fill" : "multiply")
            .foregroundColor(country.isMember ? .yellow : .red)
            .frame(width: 30, height: 30)
    }

    private func euroIcon(country: Country) -> some View {
        if country.isEuroZone {
            // Display the Euro use icon if the country is in the Eurozone
            return AnyView(Text("\u{20AC}")
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30))
        } else {
            // Display a multiply icon if the country is not in the Eurozone
            return AnyView(Image(systemName: "multiply")
                .foregroundColor(.red)
                .frame(width: 30, height: 30))
        }
    }

    private func schengenIcon(country: Country) -> some View {
        if country.isSchengen {
            // Display the Schengen Area membership icon if the country is a member
            return Image(systemName: "checkmark")
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30)
        } else {
            // Display a multiply icon if the country is not a member of the Schengen Area
            return Image(systemName: "multiply")
                .foregroundColor(.red)
                .frame(width: 30, height: 30)
        }
    }
}



// Define a preview for the main view
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CountryManager())
    }
}

