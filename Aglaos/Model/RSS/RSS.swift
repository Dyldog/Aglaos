//
//  RSS.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import FeedKit

enum RSS {    
    static func getTitle(forURL url: String, completion: @escaping Closure<Result<String, StringError>>) {
        guard let url = URL(string: url) else {
            completion(.failure(.init(error: "Couldn't parse URL")))
            return
        }
        
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                completion(.success(feed.rssFeed?.title ?? "NO TITLE"))
            case .failure(let error):
                completion(.failure(.init(error: error.errorDescription ?? "Got error but with no description")))
            }
        }
    }
}
