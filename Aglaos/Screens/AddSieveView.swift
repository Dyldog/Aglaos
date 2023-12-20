//
//  AddSieveView.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import SwiftUI

struct AddSieveView: View {
    @State var text: String = ""
    var completion: Closure<Sieve>?
    var body: some View {
        VStack {
            TextField("Sieve Title", text: $text, prompt: Text("Sieve Title"))
                .multilineTextAlignment(.center)
            Button("Add") {
                completion?(Sieve(title: text, items: []))
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(text.isEmpty)
        }
    }
}

struct AddSieveView_Previews: PreviewProvider {
    static var previews: some View {
        AddSieveView()
    }
}
