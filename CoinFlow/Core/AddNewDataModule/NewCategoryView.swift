//
//  NewCategoryView.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 18.12.2023.
//

import SwiftUI

struct NewCategoryView: View {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CDCategory.title_, ascending: true)
    ]) private var categories: FetchedResults<CDCategory>
    
    // MARK: - Environment properties
    @Environment(\.managedObjectContext) private var context
    
    // MARK: - Interaction UI properties
    @State private var emojiTextField: String = ""
    @State private var titleTextField: String = ""
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            /// Background
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            /// Main content stack
            VStack(alignment: .leading, spacing: 32) {
                /// Title and subtitle
                VStack(alignment: .leading, spacing: 4) {
                    Text("Новая категория")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    
                    Text("Создайте новую категорию. Категория хранит все ваши операции.")
                        .font(.system(size: 16, weight: .regular, design: .default))
                }
                
                /// Emoji  and title account
                HStack(alignment: .center, spacing: 8) {
                    TextField("Эмодзи", text: $emojiTextField)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(16)
                        .frame(width: 100, alignment: .center)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    TextField("Название категории", text: $titleTextField)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .padding(16)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
                /// Select color for category
                VStack(alignment: .leading, spacing: 8) {
                    Text("Select color")
                        .font(.system(size: 20, weight: .medium, design: .default))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 8) {
                            ForEach(0 ..< 10) { account in
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .frame(width: 48, height: 48, alignment: .center)
                            }
                        }
                    }
                }
                
                /// Save button
                Button(action: { saveCategory() }) {
                    Text("Сохранить")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
                /// Categories
                if !categories.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Categories")
                            .font(.system(size: 20, weight: .medium, design: .default))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 8) {
                                ForEach(categories) { category in
                                    Text("\(category.emoji) \(category.title)")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(.secondaryLabel))
                                        .padding(8)
                                        .background(Color(.tertiarySystemBackground))
                                        .clipShape(Capsule(style: .continuous))
                                }
                            }
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView()
            .environment(\.managedObjectContext, CoreDataController.preview.context)
    }
}

// MARK: - Private UI view
extension NewCategoryView {}

// MARK: - Private methods
extension NewCategoryView {
    private func saveCategory() {
        withAnimation(.easeInOut) {
            _ = CDCategory(emoji: emojiTextField, title: titleTextField, context: context)
            try? context.save()
        }
    }
}
