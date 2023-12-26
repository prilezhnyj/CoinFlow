//
//  SecondaryNavigationBar.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 20.12.2023.
//
//  Contact with me:
//  - Telegram -> t.me/prilezhnj (priority)
//  - Instagram -> instagram.com/prilezhnj
//  - VK -> vk.com/prilezhnyj
//  - GitHub -> github.com/prilezhnyj
//

import SwiftUI

struct SecondaryNavigationBar<LeadingIcon: View, TrailingIcon: View>: View {
    
    // MARK: - Public properties
    var title: String
    @ViewBuilder var leadingIcon: LeadingIcon
    @ViewBuilder var trailingIcon: TrailingIcon
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            leadingIcon
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .foregroundColor(Color(.secondaryLabel))
            
            Spacer()
            
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color(.label))
            
            Spacer()
            
            trailingIcon
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .foregroundColor(Color(.secondaryLabel))
        }
        .foregroundColor(Color(.label))
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Material.ultraThinMaterial)
    }
}

// MARK: - Preview
struct SecondaryNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryNavigationBar(title: "Title", leadingIcon: {}, trailingIcon: {})
            .previewLayout(.sizeThatFits)
    }
}
