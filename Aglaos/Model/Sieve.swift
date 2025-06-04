//
//  Sieve.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

struct Sieve: Identifiable, Codable {
    let id: UUID
    let title: String
    var items: [SieveItem]
    
    func getItems(completion: @escaping Closure<[Post]>) {
        var fetchedItems: [Post] = []
        
        for item in items {
            switch item {
            case .source(let source):
                let items = source.getPosts()
                fetchedItems += items
            case .filter(let filter):
                fetchedItems = filter.filter(fetchedItems)
            }
        }
        
        completion(fetchedItems)
    }
}

enum SieveItem: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case sourceFeed
        case filter
    }
    case source(Feed)
    case filter(Filter)
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .source(let source): return "Source: \(source.url)"
        case .filter(let filter): return "Filter: \(filter.title)"
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .filter(filter): try container.encode(filter, forKey: .filter)
        case let .source(source): try container.encode(source, forKey: .sourceFeed)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let sourceFeed = container.decodeIfPresent(Feed.self, forKey: .sourceFeed) {
            self = .source(sourceFeed)
        } else if let filter = container.decodeIfPresent(Filter.self, forKey: .filter) {
            self = .filter(filter)
        }
    }
}
