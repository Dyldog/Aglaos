//
//  ContentView.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import SwiftUI
import FeedKit

struct PostRowModel: Identifiable {
    let id: String
    let title: String
    let url: URL
    let feedTitle: String
}

class ListViewModel: NSObject, ObservableObject {
    
    let sieve: Sieve
    @Published private var posts: [Post] = []
    
    var cellModels: [PostRowModel] {
        posts.map {
            .init(id: $0.id, title: $0.title, url: $0.url, feedTitle: $0.feed.title)
        }
    }
    
    init(sieve: Sieve) {
        self.sieve = sieve
        super.init()
    }
    
    func reload() {
        sieve.getItems { items in onMain { self.posts = items } }
    }
}


struct ContentView: View {
    @ObservedObject var viewModel: ListViewModel
    
    init(sieve: Sieve) {
        self.viewModel = ListViewModel(sieve: sieve)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.cellModels) { post in
                NavigationLink(destination: {
                    Webview(url: post.url)
                }, label: {
                    PostRow(post: post)
                })
            }
        }
        .navigationTitle(viewModel.sieve.title)
        .onAppear {
            viewModel.reload()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

extension RSSFeedItem: Identifiable {
    public var id: String { return self.guid?.value ?? "NO GUID!" }
}
