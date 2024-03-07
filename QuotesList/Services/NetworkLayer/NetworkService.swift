//
//  NetworkService.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation

protocol NetworkServiceProtocol{
    func getQuoteByCatery<Request: QuotenRequestProtocol>(_ request: Request, completed: @escaping (Result<Request.Response, QuoteErrors>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func getQuoteByCatery<Request>(_ request: Request, completed: @escaping (Result<Request.Response, QuoteErrors>) -> Void) where Request : QuotenRequestProtocol {
        
        guard let url = URL(string: request.url) else {
            completed(.failure(.invalidParamName))
            return
        }
        var urlRequest = URLRequest(url: url)
        
        if let headers = request.headers {
            headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        if let parameters = request.queryItems {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            if let urlParameters = components?.url {
                urlRequest.url = urlParameters
            }
        }
        urlRequest.httpMethod = request.method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidDataFromServer))
                return
            }
            
            do {
                try completed(.success(request.decode(data)))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
}
