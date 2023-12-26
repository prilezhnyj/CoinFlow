//
//  TabBar.swift
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

enum Tab: CaseIterable {
    case today
    case operations
    case categories
    case settings
    
    var tag: Int {
        switch self {
        case .today: return 1
        case .operations: return 2
        case .categories: return 3
        case .settings: return 4
        }
    }
    
    var image: String {
        switch self {
        case .today: return "livephoto"
        case .operations: return "tray"
        case .categories: return "list.bullet"
        case .settings: return "gear"
        }
    }
    
    var title: String {
        switch self {
        case .today: return "Сегодня"
        case .operations: return "Операции"
        case .categories: return "Категории"
        case .settings: return "Настройки"
        }
    }
}

struct TabBar: View {
    
    // MARK: - Public properties
    @Binding var selectedTab: Int
    
    // MARK: - Body
    var body: some View {
        /// Main stack
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.tag) { tab in
               TabBarItem(tab: tab, selectedTab: $selectedTab)
            }
        }
        .frame(height: 60, alignment: .center)
        .background(Material.ultraThinMaterial)
    }
}

// MARK: - Preview
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(1))
            .previewLayout(.sizeThatFits)
    }
}
