//
//  Filter.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

protocol Filter {
    var title: String { get }
    func filter(_ post: Post) -> Bool
}

extension Filter {
    func filter(_ posts: [Post]) -> [Post] {
        posts.filter(self.filter)
    }
}

struct DoesntContainFilter: Filter {
    let text: String
    var title: String { "Doesn't Contain \"\(text)\""}
    
    func filter(_ post: Post) -> Bool {
        return !post.title.caseInsensitiveContains(text)
    }
}

struct ContainsFilter: Filter {
    let text: String
    var title: String { "Contains \"\(text)\""}
    
    func filter(_ post: Post) -> Bool {
        return post.title.caseInsensitiveContains(text)
    }
}

extension String {
    func caseInsensitiveContains(_ string: String) -> Bool {
        return self.lowercased().contains(string.lowercased())
    }
}
