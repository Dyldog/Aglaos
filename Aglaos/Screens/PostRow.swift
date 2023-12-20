//
//  PostRow.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import SwiftUI

struct PostRow: View {
    let post: PostRowModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
            Text(post.feedTitle)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        let feed = RSSFeed(
            title: "The Age",
            url: URL(string: "https://www.theage.com.au/rss/feed.xml")!
        )
        let post = SimplePost(
            id: UUID().uuidString,
            title: "If you could call a number and say you’re sorry, and no one would know … what would you apologize for? For fifteen years, you could call a number in Manhattan and do just that. This is the story of the apology line, and the man at the other end who became consumed by his own creation.",
            url: URL(string: "https://google.com")!,
            rssFeed: feed)
        
        return PostRow(
            post: PostRowModel(
                id: post.id,
                title: post.title,
                url: post.url,
                feedTitle: post.feed.title
            )
        )
    }
}
