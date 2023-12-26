//
//  PrimaryNavigationBar.swift
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

struct PrimaryNavigationBar: View {
    
    // MARK: - Public properties
    var fullname: String
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            /// Image
            Image("Avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 43.3333, height: 43.3333, alignment: .center)
                .clipShape(Circle())
            
            /// Welcome back and fullname
            VStack(alignment: .leading, spacing: 0) {
                Text("C возвращением,")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(Color(.secondaryLabel))
                
                Text(fullname)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(.label))
            }
            .foregroundColor(Color(.label))
            
            Spacer()
            
            /// The button to go to the screen for adding a new operation
            Button(action: { action() }) {
                Image(systemName: "plus")
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(Color(.white))
                    .frame(width: 43.3333, height: 43.3333, alignment: .center)
                    .background(Color(.systemBlue))
                    .clipShape(Circle())
                    .shadow(color: Color(.systemBlue).opacity(0.3), radius: 10, x: 0, y: 0)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Material.ultraThinMaterial)
    }
}

// MARK: - Preview
struct PrimaryNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryNavigationBar(fullname: "Prilezhnyj", action: {})
            .previewLayout(.sizeThatFits)
    }
}
