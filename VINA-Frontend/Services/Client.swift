//
//  Client.swift
//  VINA
//
//  Created by Youssef Ahab on 07/07/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
}

class Client {
    
    func getNews(url: URL) async throws -> [Article] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let article: Article = try JSONDecoder().decode(Article.self, from: data)
        print(article)
        return [article]
    }
}
