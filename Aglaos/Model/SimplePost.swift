//
//  RSSPost.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation

struct SimplePost: Post {
    let id: String
    let title: String
    let url: URL
    
    private let feedInternal: SPFeed
    
    var feed: Feed {
        switch feedInternal {
        case .rss(let feed): return feed
        }
    }
    
    init(id: String, title: String, url: URL, rssFeed: RSSFeed) {
        self.id = id
        self.title = title
        self.url = url
        self.feedInternal = .rss(rssFeed)
    }
    
    enum SPFeed {
        case rss(RSSFeed)
    }
}

