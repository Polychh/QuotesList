//
//  QuotesFavor+CoreDataProperties.swift
//  QuotesList
//
//  Created by Polina on 05.03.2024.
//
//

import Foundation
import CoreData

@objc(QuotesFavor)
public class FavorQ: NSManagedObject {

}


extension FavorQ {
    @NSManaged public var id: Int16
    @NSManaged public var category: String
    @NSManaged public var author: String
    @NSManaged public var qupteText: String
}

extension FavorQ : Identifiable {

}
