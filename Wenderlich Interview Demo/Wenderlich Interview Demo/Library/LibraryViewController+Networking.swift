//
//  ArticleViewController+Networking.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/24/22.
//

import Foundation

enum NetworkError: Error {
    case serverError
    case decodingError
}

extension LibraryViewController {
    
    func fetchArticles(completion: @escaping (Result<Content, NetworkError>) -> Void) {
        let url = URL(string: "https://api.raywenderlich.com/api/contents/")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Content.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
}
