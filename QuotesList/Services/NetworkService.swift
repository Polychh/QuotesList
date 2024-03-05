//
//  NetworkService.swift
//  QuotesList
//
//  Created by Polina on 04.03.2024.
//

import Foundation

protocol NetworkServiceProtocol{
    func getQuoteByCatery(for categoryName: String, completed: @escaping (Result<QuoteByCaregory, QuoteErrors>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://api.api-ninjas.com/v1/quotes"
    private let decoder = JSONDecoder()
    
    func getQuoteByCatery(for categoryName: String, completed: @escaping (Result<QuoteByCaregory, QuoteErrors>) -> Void) {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        
        guard let url = components?.url else {
            completed(.failure(.invalidNameVacancy))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("wEoMBZIWUSBTeyEA+KToxQ==A8hjbmq6cBYaQ73I", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
            let result = self.decodeQuote(data: data)
            completed(result)
        }
        task.resume()
    }
    
    private func decodeQuote(data: Data) -> Result<QuoteByCaregory, QuoteErrors> {
        do {
            let decodedData = try self.decoder.decode(QuoteByCaregory.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.invalidData)
        }
    }
}
