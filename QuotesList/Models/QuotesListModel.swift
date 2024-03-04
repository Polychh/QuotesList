//
//  QuotesListModel.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation



struct QuotesListModel{
    let quote: [Quote]
}

struct Quote{
    let category: String
}

extension QuotesListModel{
    static func getQuotesList() -> QuotesListModel{
        QuotesListModel(quote: [Quote(category: "Age"), Quote(category: "Alone"), Quote(category: "Art"), Quote(category: "Computers"), Quote(category: "Design"), Quote(category: "Friendship"), Quote(category: "Health"), Quote(category: "Movies"), Quote(category: "Humor"), Quote(category: "Home"), Quote(category: "Love"), Quote(category: "Life"), Quote(category: "Government"), Quote(category: "Food"), Quote(category: "Knowledge"), Quote(category: "Education"), Quote(category: "Success"), Quote(category: "Imagination")])
        
    }
}
