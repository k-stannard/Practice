//
//  Article.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/19/22.
//

import Foundation

struct Content: Codable {
    let data: [ContentData]
}

struct ContentData: Codable {
    let id: String
    let attributes: ArticlesAndVideos
}

struct ArticlesAndVideos: Codable {
    let name: String
    let releasedAt: String
    let free: Bool
    let difficulty: String?
    let contentType: String
    let duration: Int
    let technologyTripleString: String
    let contributorString: String
    let descriptionPlainText: String
    let cardArtworkUrl: URL
}
