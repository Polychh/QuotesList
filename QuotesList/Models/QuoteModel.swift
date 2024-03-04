//
//  QuoteModel.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation


struct QuoteModel: Decodable {
    let quote, author, category: String
}

typealias QuoteByCaregory = [QuoteModel]
