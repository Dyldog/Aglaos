//
//  FeedKit+Extensions.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

extension RSSFeedItem {
    func asPost(withFeed feed: RSSFeed) -> Post {
        let url: URL
        
        if let postURLStr = self.link, let postURL = URL(string: postURLStr) {
            url = postURL
        } else {
            url = URL(string: "https://google.com")!
        }
        return SimplePost(
            id: self.guid?.value ?? UUID().uuidString,
            title: self.title ?? "NO TITLE",
            url: url,
            rssFeed: feed
        )
    }
}
