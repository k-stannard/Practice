//
//  NetworkManager.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/24/22.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case serverError
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchContent(url: URL, completion: @escaping (Result<[ContentData], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let content = try decoder.decode(Content.self, from: data)
                let result = content.data
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
}
