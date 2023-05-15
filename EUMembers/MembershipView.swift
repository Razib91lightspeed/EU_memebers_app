//
//  MembershipView.swift
//  EUMembers
//
//  Created by Razib Hasan on 01.05.2023.
//

import SwiftUI

struct MembershipView: View {
    @Binding var country: Country
    
    var body: some View {
        HStack {
            if country.isMember {
                Image(systemName: "star.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)
            }
            
            if country.isEuroZone {
                Text("\u{20AC}")
                    .foregroundColor(.yellow)
                    .font(.system(size: 40))
            }
            if country.isSchengen{
                Image(systemName: "checkmark")
                    .foregroundColor(.yellow)
                    .font(.system(size: 40))
            }
        }
    }
}
