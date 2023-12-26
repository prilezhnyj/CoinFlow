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

struct CategoryRow: View {
    
    // MARK: - Public properties
    @ObservedObject var category: FetchedResults<CDCategory>.Element
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 16) {
                /// Emoji
                Text(category.emoji)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color(.label))
                    .frame(width: 40.3333, height: 40.3333, alignment: .center)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
                
                /// Title
                Text(category.title)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(.label))
                
                Spacer()
                
                /// More button
                Image(systemName: "ellipsis")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(.secondaryLabel))
            }
            .padding(.horizontal, 8)
            
            /// ScrollView  with 4 last operations
            if !category.operations.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(Array(category.operations.prefix(4))) { operation in
                            Text(operation.amount.currency)
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(Color(.white))
                                .lineLimit(1)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(operation.isExpense ? Color(.systemRed) : Color(.systemGreen))
                                .clipShape(Capsule(style: .continuous))
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
        }
        .padding(.vertical, 8)
        .background(Material.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// MARK: - Preview
struct CategoryOverviewCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(category: .preview)
            .previewLayout(.sizeThatFits)
    }
}
