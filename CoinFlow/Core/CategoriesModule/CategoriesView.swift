//
//  CategoriesView.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 20.12.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    // MARK: - Private properties
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \CDCategory.title_, ascending: true)], animation: .easeInOut) private var categories: FetchedResults<CDCategory>
    
    // MARK: - Environment properties
    @Environment(\.managedObjectContext) private var context
    
    // MARK: - Body
    var body: some View {
        ZStack {
            /// Background
            Color(.secondarySystemBackground).ignoresSafeArea()
            
            /// Main stask
            VStack(alignment: .center) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 24) {
                        /// Expenses section
                        LazyVStack(alignment: .center, spacing: 8, pinnedViews: []) {
                            ForEach(categories) { category in
                                NavigationLink {
                                    OperationsCategoryView(category: category)
                                } label: {
                                    CategoryOverviewCellView(category: category)
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
            SecondaryHeaderView(title: "Категории") {
                Image(systemName: "plus")
                    .opacity(0)
            } trailingIcon: {
                NavigationLink {
                    NewCategoryView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

// MARK: - Preview
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environment(\.managedObjectContext, CoreDataController.preview.context)
    }
}

// MARK: - Private methods
/*
extension CategoriesView {
    private var expensesOperations: [CDOperation] {
        operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ $0.isExpense })
    }
    
    private var incomeOperations: [CDOperation] {
        operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ !$0.isExpense })
    }
    
    private var amountExpensesOperations: String {
        operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ $0.isExpense })
            .map({ $0.amount })
            .reduce(0, +).currency
    }
    
    private var amountIncomeOperations: String {
        operations
            .filter({ $0.dateCreation.dayWeekShort == selectedDate.dayWeekShort })
            .filter({ !$0.isExpense })
            .map({ $0.amount })
            .reduce(0, +).currency
    }
}
*/
