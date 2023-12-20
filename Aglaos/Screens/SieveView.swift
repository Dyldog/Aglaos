//
//  SieveView.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import SwiftUI
import FeedKit

class SieveViewModel: ObservableObject {
    @Published private(set) var sieve: Sieve
    
    init(sieve: Sieve) {
        self.sieve = sieve
    }
    
    func addSource(_ source: RSSFeed) {
        sieve.items.append(.source(source))
    }
    func addFilter(_ filter: Filter) {
        sieve.items.append(.filter(filter))
    }
    
//    func addSieve(_ sieve: Sieve) {
//
//    }
    
    func removeItem(at index: Int) {
        sieve.items.remove(at: index)
    }
}

struct SieveView: View {
    @ObservedObject var viewModel: SieveViewModel
    
    @State var showAddSourceView: Bool = false
    @State var showAddFilterView: Bool = false
    @State var showAddSieveView: Bool = false
    @State var showAddSheet: Bool = false
    init(sieve: Sieve) {
        viewModel = SieveViewModel(sieve: sieve)
    }
    var body: some View {
        List {
            let items = viewModel.sieve.items
            ForEach(Array(zip(items.indices, items)), id: \.0) { item in
                VStack(alignment: .leading) {
                    switch item.1 {
                    case .source(let feed): SourceRow(feed: feed)
                    case .filter(let filter): FilterRow(filter: filter)
                    }
                }
                .swipeActions {
                    Button {
                        viewModel.removeItem(at: item.0)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)

                }
            }
            
            NavigationLink("Show Posts") {
                ContentView(sieve: viewModel.sieve)
            }
        }
        .navigationTitle(viewModel.sieve.title)
        .toolbar {
            Button("Add") {
                showAddSheet = true
            }
        }
        .confirmationDialog("Add", isPresented: $showAddSheet, actions: {
            Button("Source", action: { self.showAddSourceView = true })
            Button("Filter", action: { self.showAddFilterView = true })
        })
        .popover(isPresented: $showAddFilterView) {
            AddFilterView(completion: { filter in
                viewModel.addFilter(filter)
                showAddFilterView = false
            })
        }
//        .popover(isPresented: $showAddSieveView) {
//            SearchView(
//                title: "Add Sieve",
//                items: [], completion: { subSieve, _ in
//                    // Add to parent sieve
//                }
//            )
//        }
        .popover(isPresented: $showAddSourceView) {
            AddSourceView { source in
                viewModel.addSource(source)
                showAddSourceView = false
            }
        }
    }
}

struct SourceRow: View {
    let feed: Feed
    
    var body: some View {
        HStack {
            Image(systemName: "sun.max.fill")
                .foregroundColor(.orange)
            
            VStack(alignment: .leading) {
                Text("\(feed.title)")
                Text(feed.url.absoluteString)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
        }
    }
}

struct FilterRow: View {
    let filter: Filter
    
    var body: some View {
        HStack {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("\(filter.title)")
            }
        }
    }
}
