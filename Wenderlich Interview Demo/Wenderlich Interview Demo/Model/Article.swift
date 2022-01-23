//
//  Article.swift
//  Wenderlich Interview Demo
//
//  Created by Koty Stannard on 1/19/22.
//

import Foundation

struct ArticleData: Codable {
    let id: String
    let attributes: Article
}

struct Article: Codable {
    let name: String
    let released_at: Date
    let free: Bool
    let difficulty: String
    let content_type: String
    let duration: Int
    let technology_triple_string: String
    let contributor_string: String
    let description_plain_text: String
    let card_artwork_url: URL
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
