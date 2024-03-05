//
//  StoreManager.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//

import UIKit
import CoreData

final class StoreManager{
    private static let shared = StoreManager()
    private let containerName: String = "FavoriteQuotes"
    private let entityName: String = "FavorQ"
    
    private init(){}
    
    private var appDelagate: AppDelegate{
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext{
        appDelagate.persistentContainer.viewContext
    }
    
    func createFavoriteQuote(id: Int,category: String, author: String, quoteText: String){
        guard let quoteEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        let quote = FavorQ(entity: quoteEntityDescription, insertInto: context)
        quote.id = Int16(id)
        quote.category = category
        quote.author = author
        quote.qupteText = quoteText
        appDelagate.saveContext()
    }
    
    func fetchQuotes() -> [FavorQ]{
        let fetchRequest = NSFetchRequest<FavorQ>(entityName: entityName)
        do{
            let quotes = (try? context.fetch(fetchRequest)) ?? []
            return quotes
        }
       
        //        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName) //получит все объекты типа "FavorQ"
//
//        do{
//            return (try? context.fetch(request) as? [FavorQ]) ?? []
//        }
        
    }
    
    func deleteAllQuotes(){
        let fetchRequest = NSFetchRequest<FavorQ>(entityName: entityName)
        do{
            let quotes = try? context.fetch(fetchRequest)
            quotes?.forEach{ context.delete($0)}
        }
        appDelagate.saveContext()
    }
    
    func deleteOneQuotes(with index: Int){
        let fetchRequest = NSFetchRequest<FavorQ>(entityName: entityName)
        do{
            guard let quotes = try? context.fetch(fetchRequest),
                  let quote = quotes.first(where: { $0.id == Int16(index)}) else { return }
            context.delete(quote)
        }
        appDelagate.saveContext()
    }
    
}
