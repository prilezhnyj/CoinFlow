//
//  TabBarItem.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 27.12.2023.
//
//  Contact with me:
//  - Telegram -> t.me/prilezhnj (priority)
//  - Instagram -> instagram.com/prilezhnj
//  - VK -> vk.com/prilezhnyj
//  - GitHub -> github.com/prilezhnyj
//

import SwiftUI

struct TabBarItem: View {
    
    // MARK: - Public properties
    var tab: Tab
    @Binding var selectedTab: Int
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Image(systemName: tab.image)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .frame(width: 28, height: 28, alignment: .center)
            Text(tab.title)
        }
        .frame(height: 60, alignment: .center)
        .frame(maxWidth: .infinity, alignment: .center)
        .font(.system(size: 14, weight: .semibold, design: .rounded))
        .foregroundColor(foregroundColor)
        .onTapGesture { $selectedTab.wrappedValue = tab.tag }
    }
}

// MARK: - Preview
struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(tab: .categories, selectedTab: .constant(1))
    }
}

// MARK: - Private properties and methods
extension TabBarItem {
    private var foregroundColor: Color {
        $selectedTab.wrappedValue == tab.tag ? Color(.systemBlue) : Color(.tertiaryLabel)
    }
}
