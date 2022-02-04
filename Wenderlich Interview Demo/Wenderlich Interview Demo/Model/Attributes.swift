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
    let attributes: Attributes
}

struct Attributes: Codable {
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

enum AttributeType {
    case article, video, both
}

extension Attributes {
    
    var accessLevel: String {
        free == true ? "Free" : "Pro"
    }
    
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withFractionalSeconds]
        let isoDate = isoFormatter.date(from: releasedAt)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d yyyy"
        
        return dateFormatter.string(from: isoDate!)
    }
    
    var formattedDuration: String {
        let minsAndHoursTuple = duration.minutesToHoursAndMinutes(duration)
        var formattedString: String
        
        switch contentType {
        case "collection":
            if minsAndHoursTuple.hours > 0 {
                formattedString = "Video Course (\(minsAndHoursTuple.hours) hrs, \(minsAndHoursTuple.leftMinutes) mins)"
            } else {
                formattedString = "Video Course (\(minsAndHoursTuple.leftMinutes) mins)"
            }
        case "article":
            if minsAndHoursTuple.hours > 0 {
                formattedString = "Article (\(minsAndHoursTuple.hours) hrs, \(minsAndHoursTuple.leftMinutes) mins)"
            } else {
                formattedString = "Article (\(minsAndHoursTuple.leftMinutes) minute read)"
            }
        default:
            formattedString = ""
        }

        return formattedString
    }
}
