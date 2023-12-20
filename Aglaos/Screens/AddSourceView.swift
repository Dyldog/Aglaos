//
//  AddSourceView.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import Foundation
import SwiftUI

struct AddSourceView: View {
    @State var text: String = ""
    var completion: Closure<RSSFeed>?
    @State var errorAlertBody: String?
    var showErrorAlert: Binding<Bool> {
        .init(
            get: { errorAlertBody != nil },
            set: { if $0 == false { errorAlertBody = nil } }
        )
    }
    
    var body: some View {
        VStack {
            TextField("Source URL", text: $text, prompt: Text("Source URL"))
                .multilineTextAlignment(.center)
            Text("URL must point to an RSS feed")
                .font(.footnote)
            Button("Add") {
                RSS.getTitle(forURL: text) { result in
                    switch result {
                    case .success(let title):
                        completion?(RSSFeed(title: title, url: URL(string: text)!))
                    case .failure(let error):
                        errorAlertBody = error.error
                    }
                }
                
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(text.isEmpty)
        }
        .alert("Error adding feed", isPresented: showErrorAlert, actions: {}, message: {
            Text(errorAlertBody ?? "NO ERROR")
        })
    }
}
