//
//  JokeRequest.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import Foundation
struct JokeRequest: QuotenRequestProtocol{
    typealias Response = Jokes
    
    private let limit: Int = 30
   
    
    var url: String {
        let baseUrl = "https://api.api-ninjas.com/v1/jokes"
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
            "limit": "\(limit)",
        ]
        return params
    }
}
