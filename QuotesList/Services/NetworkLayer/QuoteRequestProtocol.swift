//
//  QuoteRequest.swift
//  QuotesList
//
//  Created by Polina on 07.03.2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol QuotenRequestProtocol {
    associatedtype Response

    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var queryItems: [String : String]? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension QuotenRequestProtocol where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}

