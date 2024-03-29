//
//  ResultList.swift
//  BucketList
//
//  Created by Mehmet Ateş on 4.06.2022.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    let thumbnail: Thumbnail?
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
}

struct Thumbnail: Codable, Comparable{
    static func <(lhs: Thumbnail, rhs: Thumbnail) -> Bool {
        lhs.width < rhs.width
    }
    
    let source: String
    let width: Int
    let height: Int
}
