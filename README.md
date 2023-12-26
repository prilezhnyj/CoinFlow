# CoinFlow
Hi, my name is Maksim Botalov! I have been developing iOS for 3 years.
Today, let's take a look at the CoinFlow application, which allows you to control your expenses and income.

## Main features
- The main screen with operations for today
- Creating, changing, editing operations
- Creating, changing, editing categories
- Filtering operations by category, by date, by type
- Full support for light and dark themes

## Frameworks
- The UI is completely written in SwiftUI
- All data is stored in CoreData

## Architecture
> The application is written on a Single architecture using the extension of structures
> All database requests were made via @FetchRequest

## Requests to CoreData
> I did not prescribe requests in the extensions of the entity, because I thought it was better to do them in the View itself. This way they will be more flexible than doing it in extensions.

- Example
```sh
        @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CDCategory.title_, ascending: true)
        ]) private var categories: FetchedResults<CDCategory>
```

## To work with the preview, instances were written
```sh
    static var preview: CDCategory {
        let context = CoreDataController.preview.context
        return CDCategory(emoji: "😀", title: "Preview title", context: context)
    }
```

## To get rid of the options in CoreData, syntactic sugar was applied
```sh
    var operations: Set<CDOperation> {
        get { (operations_ as? Set<CDOperation>) ?? [] }
        set { operations_ = newValue as NSSet }
    }
```

## Convenient initializers have been written for each Entity
```sh
    convenience init(emoji: String, title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.emoji = emoji
        self.title = title
    }
```

## My contacts
- [Telegram](https://t.me/prilezhnyj/)
- dev.botalov@gmail.com

## My resume
- [My resume is on hh.ru](https://perm.hh.ru/resume/2860b941ff0c8986830039ed1f385437385559)

## Screenshots
![Screenshot](https://github.com/prilezhnyj/CoinFlow/blob/main/CoinFlow/Light%20theme.png)
![Screenshot](https://github.com/prilezhnyj/CoinFlow/blob/main/CoinFlow/Dark%20theme.png)
