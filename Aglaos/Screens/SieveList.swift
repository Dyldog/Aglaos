//
//  SieveList.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import SwiftUI

class SieveListViewModel: ObservableObject {
    @Published var sieves: [Sieve] = [
        .init(title: "Test Sieve", items: [
            .source(RSSFeed(
                title: "The Age",
                url: URL(string: "https://www.theage.com.au/rss/feed.xml")!
            )),
            .filter(ContainsFilter(text: "RAT"))
        ])
    ]
    
    func addSieve(_ sieve: Sieve) {
        sieves.append(sieve)
    }
}
struct SieveList: View {
    @ObservedObject var viewModel = SieveListViewModel()
    
    @State var showAddView: Bool = false
    
    var body: some View {
        List {
            ForEach(viewModel.sieves) { sieve in
                NavigationLink(sieve.title) {
                    SieveView(sieve: sieve)
                }
            }
        }
        .navigationTitle("Sieves")
        .toolbar {
            Button("Add") {
                showAddView = true
            }
        }
        .popover(isPresented: $showAddView) {
            AddSieveView(completion: { sieve in
                viewModel.addSieve(sieve)
                showAddView = false
            })
        }
    }
}

struct SieveList_Previews: PreviewProvider {
    static var previews: some View {
        SieveList()
    }
}
