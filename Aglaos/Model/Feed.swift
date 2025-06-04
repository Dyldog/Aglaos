//
//  Feed.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation

protocol Feed: Codable {
    var id: String { get }
    var title: String { get }
    var url: URL { get }
    
    func getPosts() -> [Post]
}
