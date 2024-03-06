//
//  StoreManager.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit
import CoreData

final class StoreManager{
    static let shared = StoreManager()
    private let entityName: String = "SavesQuote"
    
    private init(){}
    
    private var appDelagate: AppDelegate{
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext{
        appDelagate.persistentContainer.viewContext
    }
    
    func createFavoriteQuote(category: String, author: String, quoteText: String){
        guard let quoteEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        let quote = SavesQuote(entity: quoteEntityDescription, insertInto: context)
        quote.category = category
        quote.author = author
        quote.quoteText = quoteText
        print("save quote \(quote)")
        appDelagate.saveContext()
    }
    
    func fetchQuotes() -> [SavesQuote]{
        let fetchRequest = NSFetchRequest<SavesQuote>(entityName: entityName)
        do{
            let quotes = (try? context.fetch(fetchRequest)) ?? []
//            for quote in quotes{
//                print("all quotes \(quote.author)")
//            }
            
            return quotes
        }
    }
    //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName) //получит все объекты типа "FavorQ"
//
//        do{
//            return (try? context.fetch(request) as? [FavorQ]) ?? []
//        }
    
    func deleteAllQuotes(){
        let fetchRequest = NSFetchRequest<SavesQuote>(entityName: entityName)
        do{
            let quotes = try? context.fetch(fetchRequest)
            quotes?.forEach{ context.delete($0)}
        }
        appDelagate.saveContext()
    }
    
    func deleteOneQuotes(with quoteText: String){
        let fetchRequest = NSFetchRequest<SavesQuote>(entityName: entityName)
        do{
            guard let quotes = try? context.fetch(fetchRequest),
                  let quote = quotes.first(where: { $0.quoteText == quoteText}) else { return }
            context.delete(quote)
        }
        appDelagate.saveContext()
    }
    
}
