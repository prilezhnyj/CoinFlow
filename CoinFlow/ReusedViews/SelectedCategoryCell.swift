//
//  SelectedCategoryCell.swift
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

struct SelectedCategoryCell: View {
    
    // MARK: - Public properties
    var category: CDCategory
    @Binding var selectedCategory: CDCategory?
    
    // MARK: - Body
    var body: some View {
        Text("\(category.emoji) \(category.title)")
            .lineLimit(1)
            .font(.system(size: 14, weight: .semibold, design: .default))
            .foregroundColor(foregroundColor)
            .frame(height: 32, alignment: .center)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(background)
            .clipShape(Capsule(style: .continuous))
            .onTapGesture {
                withAnimation(.easeInOut, { selectedCategory = category })
            }
    }
}

// MARK: - Preview
struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedCategoryCell(category: .preview, selectedCategory: .constant(.preview))
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Private properties and methods
extension SelectedCategoryCell {
    var foregroundColor: Color {
        selectedCategory == category ?Color(.systemBlue) : Color(.secondaryLabel)
    }
    
    var background: Color {
        selectedCategory == category ? Color(.systemBlue.withAlphaComponent(0.2)) : Color(.systemGray5)
    }
}
