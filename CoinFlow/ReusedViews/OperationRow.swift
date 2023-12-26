//
//  OperationRowView.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 19.12.2023.
//
//  Contact with me:
//  - Telegram -> t.me/prilezhnj (priority)
//  - Instagram -> instagram.com/prilezhnj
//  - VK -> vk.com/prilezhnyj
//  - GitHub -> github.com/prilezhnyj
//
import SwiftUI

struct OperationRow: View {
    
    // MARK: - Public properties
    @ObservedObject var operation: FetchedResults<CDOperation>.Element
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            /// Emoji
            Text(operation.category.emoji)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(width: 40.3333, height: 40.3333, alignment: .center)
                .background(Material.ultraThinMaterial)
                .clipShape(Circle())
            
            /// Title and description
            VStack(alignment: .leading, spacing: 4) {
                Text(operation.category.title)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(Color(.label))
                
                if !operation.descript.isEmpty {
                    Text(operation.descript)
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(Color(.secondaryLabel))
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            /// Amount and date creation
            VStack(alignment: .trailing, spacing: 4) {
                Text(operation.amount.currency)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .foregroundColor(operation.isExpense ? Color(.systemRed) : Color(.systemGreen))
                
                Text(operation.dateCreation.time)
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
            }
        }
    }
}

// MARK: - Preview
struct OperationRowView_Previews: PreviewProvider {
    static var previews: some View {
        OperationRow(operation: .preview)
            .previewLayout(.sizeThatFits)
    }
}
