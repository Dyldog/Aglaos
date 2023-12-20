//
//  RSSFeed.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

struct RSSFeed: Feed {
    var id: String { url.absoluteString }
    
    func getPosts() -> [Post] {
        let parser = FeedParser(URL: url)
        print("Getting feed...")
        switch parser.parse() {
        case .success(let feed):
            guard let items = feed.rssFeed?.items else { return [] }
            print("Got \(items.count) items")
            return items.map {
                $0.asPost(withFeed: self)
            }
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    let title: String
    let url: URL
    
}

