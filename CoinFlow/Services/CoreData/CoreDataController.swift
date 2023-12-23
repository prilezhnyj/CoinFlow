//
//  CoreDataController.swift
//  CoinFlow
//
//  Created by Maksim Botalov on 18.12.2023.
//

import CoreData

struct CoreDataController {
    static let shared = CoreDataController()
    
    let context: NSManagedObjectContext
    
    private let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataContainer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext
    }
    
    private func mockData() {
        _ = CDAccount(emoji: "💳", title: "Card", context: context)
        _ = CDAccount(emoji: "💵", title: "Cash", context: context)
        _ = CDCategory(emoji: "🏡", title: "Home", context: context)
        try? context.save()
        
    }
    
    // MARK: - Preview
    static var preview: CoreDataController = {
        let coreDataController = CoreDataController(inMemory: true)
        let context = coreDataController.context
        for indexAccount in 0 ..< 10 {
            let mockAccount = CDAccount(emoji: "💳", title: "Mock account \(indexAccount)", context: context)
            
            for indexCategory in 0 ..< 10 {
                let mockCategory = CDCategory(emoji: "😀", title: "Mock category \(indexCategory)", context: context)
            }
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return coreDataController
    }()
}
