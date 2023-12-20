//
//  Sieve.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

struct Sieve: Identifiable {
    let id: UUID = .init()
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

enum SieveItem: Identifiable {
    case source(Feed)
    case filter(Filter)
    
    var id: String { title }
    
    var title: String {
        switch self {
        case .source(let source): return "Source: \(source.url)"
        case .filter(let filter): return "Filter: \(filter.title)"
        }
    }
}
