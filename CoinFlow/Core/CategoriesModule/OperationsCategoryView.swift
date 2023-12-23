//
//  OperationsCategoryView.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 20.12.2023.
//

import SwiftUI

struct OperationsCategoryView: View {
    
    // MARK: - Private properties
    @ObservedObject var category: CDCategory
    
    // MARK: - Environment properties
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Interaction UI properties
    @State private var selectedDate: Date = Date()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            /// Background
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            /// Main stask
            VStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 24) {
                        /// DatePicker
                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                        
                        /// Expenses section
                        LazyVStack(alignment: .center, spacing: 8, pinnedViews: []) {
                            Section {
                                ForEach(expensesOperations) { operation in
                                    OperationRowView(operation: operation)
                                }
                            } header: {
                                if !expensesOperations.isEmpty {
                                    HStack(alignment: .center, spacing: 16) {
                                        Text("Расходы")
                                        Spacer()
                                        Text(amountExpensesOperations)
                                        
                                    }
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .foregroundColor(Color(.secondaryLabel))
                                }
                            }
                        }

                        /// Income section
                        LazyVStack(alignment: .center, spacing: 8, pinnedViews: []) {
                            Section {
                                ForEach(incomeOperations) { operation in
                                    OperationRowView(operation: operation)
                                }
                            } header: {
                                if !incomeOperations.isEmpty {
                                    HStack(alignment: .center, spacing: 16) {
                                        Text("Доходы")
                                        Spacer()
                                        Text(amountIncomeOperations)
                                        
                                    }
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .foregroundColor(Color(.secondaryLabel))
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 40, trailing: 16))
                }
            }
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top) {
            SecondaryHeaderView(title: "\(category.emoji) \(category.title)") {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                }
            } trailingIcon: {
                Image(systemName: "plus")
                   .opacity(0)
            }
        }
    }
}

// MARK: - Preview
struct OperationsCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsCategoryView(category: .preview)
            .environment(\.managedObjectContext, CoreDataController.preview.context)
    }
}

// MARK: - Private methods
extension OperationsCategoryView {
    private var expensesOperations: [CDOperation] {
        category.operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ $0.isExpense })
    }
    
    private var incomeOperations: [CDOperation] {
        category.operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ !$0.isExpense })
    }
    
    private var amountExpensesOperations: String {
        category.operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ $0.isExpense })
            .map({ $0.amount })
            .reduce(0, +).currency
    }
    
    private var amountIncomeOperations: String {
        category.operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ !$0.isExpense })
            .map({ $0.amount })
            .reduce(0, +).currency
    }
}

