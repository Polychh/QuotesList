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
    
//    private let baseURL = "https://api.api-ninjas.com/v1/quotes"
//    private let decoder = JSONDecoder()
//    
//    func getQuoteByCatery(for categoryName: String, completed: @escaping (Result<QuoteByCaregory, QuoteErrors>) -> Void) {
//        var components = URLComponents(string: baseURL)
//        components?.queryItems = [URLQueryItem(name: "category", value: categoryName)]
//        
//        guard let url = components?.url else {
//            completed(.failure(.invalidNameVacancy))
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.setValue("YOUR_KEY", forHTTPHeaderField: "X-Api-Key")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let _ = error{
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
//                completed(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else{
//                completed(.failure(.invalidDataFromServer))
//                return
//            }
//            let result = self.decodeQuote(data: data)
//            completed(result)
//        }
//        task.resume()
//    }
//    
//    private func decodeQuote(data: Data) -> Result<QuoteByCaregory, QuoteErrors> {
//        do {
//            let decodedData = try self.decoder.decode(QuoteByCaregory.self, from: data)
//            return .success(decodedData)
//        } catch {
//            return .failure(.invalidData)
//        }
//    }
}

//func request<Request: QuestionRequestProtocol>(_ request: Request) async throws -> Request.Response {
//    guard let url = URL(string: request.url) else { throw NetworkErrors.invalidURL }
//    var urlRequest = URLRequest(url: url)
//    
//    if let headers = request.headers {
//        headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
//    }
//    
//    if let parameters = request.queryItems {
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
//        if let urlParameters = components?.url {
//            urlRequest.url = urlParameters
//        }
//    }
//    urlRequest.httpMethod = request.method.rawValue
//    
//    let (data, response) = try await URLSession.shared.data(for: urlRequest)
//    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//        throw NetworkErrors.invalidResponse}
//    do {
//        let questionInfo = try request.decode(data)
//        return questionInfo
//    } catch {
//        throw NetworkErrors.invalidData
//    }
//}
//}


//protocol Network {
//    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, HHError>) -> Void)
//}
//
//final class DefaultNetworkService: Network {
//    
//    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, HHError>) -> Void) {
//        guard let url = URL(string: request.url.fullPath) else {
//            completion(.failure(.invalidNameVacancy))
//            return
//        }
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = request.method.rawValue
//        
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let _ = error {
//                return completion(.failure(.unableToComplete))
//            }
//            
//            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
//                return completion(.failure(.invalidResponse))
//            }
//            
//            guard let data = data else {
//                return completion(.failure(.invalidDataFromServer))
//            }
//            
//            do {
//                try completion(.success(request.decode(data)))
//            } catch {
//                completion(.failure(.invalidData))
//            }
//        }
//        .resume()
//    }
//}
