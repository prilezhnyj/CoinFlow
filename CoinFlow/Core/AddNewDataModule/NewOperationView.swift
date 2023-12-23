//
//  NewOperationView.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 18.12.2023.
//

import SwiftUI

struct NewOperationView: View {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CDAccount.title_, ascending: true)
    ]) private var accounts: FetchedResults<CDAccount>
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CDCategory.title_, ascending: true)
    ]) private var categories: FetchedResults<CDCategory>
    
    // MARK: - Environment properties
    @Environment(\.managedObjectContext) private var context
    
    // MARK: - Interaction UI properties
    @State private var amountTextField: String = ""
    @State private var descriptTextField: String = ""
    @State private var isExpense: Bool = false
    @State private var selectedAccount: CDAccount?
    @State private var selectedCategory: CDCategory?
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            /// Background
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            /// Main content stack
            VStack(alignment: .leading, spacing: 32) {
                /// Title and subtitle
                VStack(alignment: .leading, spacing: 4) {
                    Text("Новая операция")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    
                    Text("Для сохранения операции необходимо ввести сумму операции, выбрать счёт и категорию.")
                        .font(.system(size: 16, weight: .regular, design: .default))
                }
                
                /// Amount
                HStack(alignment: .center, spacing: 2) {
                    Text("$")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                    
                    TextField("0.00", text: $amountTextField)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .keyboardType(.decimalPad)
                }
                
                /// Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.system(size: 20, weight: .medium, design: .default))
                    
                    TextEditor(text: $descriptTextField)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .padding(8)
                        .frame(height: 100, alignment: .center)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
                /// Selected account
                if !accounts.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Account")
                            .font(.system(size: 20, weight: .medium, design: .default))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 8) {
                                ForEach(accounts) { account in
                                    Text("\(account.emoji) \(account.title)")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(selectedAccount == account ? Color(.systemBlue) : Color(.secondaryLabel))
                                        .padding(8)
                                        .background(selectedAccount == account ? Color(.systemBlue.withAlphaComponent(0.2)) : Color(.tertiarySystemBackground))
                                        .clipShape(Capsule(style: .continuous))
                                        .onTapGesture {
                                            withAnimation(.easeInOut, { selectedAccount = account })
                                        }
                                }
                            }
                        }
                    }
                }
                
                /// Selected category
                if selectedAccount != nil {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category")
                            .font(.system(size: 20, weight: .medium, design: .default))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 8) {
                                ForEach(categories) { category in
                                    Text("\(category.emoji) \(category.title)")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(selectedCategory == category ? Color(.systemBlue) : Color(.secondaryLabel))
                                        .padding(8)
                                        .background(selectedCategory == category ? Color(.systemBlue.withAlphaComponent(0.2)) : Color(.tertiarySystemBackground))
                                        .clipShape(Capsule(style: .continuous))
                                        .onTapGesture {
                                            withAnimation(.easeInOut, { selectedCategory = category })
                                        }
                                }
                            }
                        }
                    }
                }
                
                /// Save button
                Button(action: { saveOperation() }) {
                    Text("Сохранить")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                        .background((selectedAccount == nil || selectedCategory == nil) ? Color(.systemGray4) : Color(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .disabled(selectedAccount == nil || selectedCategory == nil)
            }
            .padding(16)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview
struct NewOperationView_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView()
            .environment(\.managedObjectContext, CoreDataController.preview.context)
    }
}

// MARK: - Private UI view
extension NewOperationView {}

// MARK: - Private methods
extension NewOperationView {
    private func saveOperation() {
        withAnimation(.easeInOut) {
            guard let account = selectedAccount else { return }
            guard let category = selectedCategory else { return }
            guard let amountDouble = Double(amountTextField) else { return }
            let operation = CDOperation(descript: descriptTextField, amount: amountDouble, isExpense: isExpense, context: context)
            
            account.addToOperations_(operation)
            category.addToOperations_(operation)
            
            try? context.save()
        }
    }
}
