//
//  Article.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/19/22.
//

import Foundation

struct Content: Codable {
    let data: [ArticleData]
    //let includedData: [IncludedData]
}

struct ArticleData: Codable {
    let id: String
    let attributes: Article
}

struct Article: Codable {
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

struct IncludedData: Codable {
    let included: Included
}

struct Included: Codable {
    let id: String
    let attributes: IncludedAttributes
}

struct IncludedAttributes: Codable {
    let name: String
    let slug: String
    let description: String
    let level: String
}
