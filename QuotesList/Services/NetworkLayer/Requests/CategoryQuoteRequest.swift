//
//  CategoryQuoteRequest.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import Foundation
struct CategoryQuoteRequest: QuotenRequestProtocol{
    typealias Response = QuoteByCaregory
    
    let category: String
   
    
    var url: String {
        let baseUrl = "https://api.api-ninjas.com/v1/quotes"
        return baseUrl
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]?{
        let headers = [
            "X-Api-Key": "UUGzMqF7CB21vbyipMvSahLLw0vXjhsKJBaKNVCd",
        ]
        return headers
    }
    
    var queryItems: [String : String]?{
        let params = [
            "category": "\(category)",
        ]
        return params
    }
}
