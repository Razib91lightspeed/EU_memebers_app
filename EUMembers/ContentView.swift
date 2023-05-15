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

// Define the view for a single country in the list
struct Custom_Row_View: View {
    
    // Get the country object for this row
    var country: Country
    
    // Define the body of the view
    var body: some View {
        NavigationLink(destination: CountryView(country: country)) {
            // Display the country flag, name, and icons indicating membership in the EU, use of the Euro, and membership in the Schengen Area
            HStack {
                flagImage(country: country)
                Text(country.name)
                Spacer()
                starIcon(country: country)
                euroIcon(country: country)
                schengenIcon(country: country)
            }
        }
    }
    
    // Display the country flag image
    private func flagImage(country: Country) -> some View {
        Image(country.code.lowercased())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 20)
    }
    
    // Display the EU membership icon
    private func starIcon(country: Country) -> some View {
        Image(systemName: country.isMember ? "star.fill" : "multiply")
            .foregroundColor(country.isMember ? .yellow : .red)
            .frame(width: 30, height: 30)
    }
    
    // Display the Euro use icon
    private func euroIcon(country: Country) -> some View {
        if country.isEuroZone {
            return AnyView(Text("\u{20AC}")
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30))
        } else {
            return AnyView(Image(systemName: "multiply")
                .foregroundColor(.red)
                .frame(width: 30, height: 30))
        }
    }

    // Display the Schengen Area membership icon
    private func schengenIcon(country: Country) -> some View {
        if country.isSchengen {
            return Image(systemName: "checkmark")
                .foregroundColor(.yellow)
                .frame(width: 30, height: 30)
        } else {
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

