//
//  CategoryRow.swift
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

struct SectionHeader: View {
    
    // MARK: - Public properties
    var title: String
    var amount: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text(title)
            Spacer()
            Text(amount)
        }
        .font(.system(size: 16, weight: .semibold, design: .default))
        .foregroundColor(Color(.secondaryLabel))
    }
}

// MARK: - Preview
struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(title: "Title", amount: "Amount")
            .previewLayout(.sizeThatFits)
            .background(Color(.secondarySystemBackground))
    }
}
