//
//  AddFilterView.swift
//  Aglaos
//
//  Created by Dylan Elliott on 14/11/21.
//

import SwiftUI

struct AddFilterView: View {
    @State var text: String = ""
    var completion: Closure<Filter>?
    @State var filterType: FilterType = .contains
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                Spacer().frame(height: 10)
                
                Picker("Type", selection: $filterType) {
                    ForEach(FilterType.allCases) {
                        Text($0.title).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Filter Text", text: $text, prompt: Text("Filter Text"))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer().frame(height: 10)
                
                Button("Add") {
                    completion?(makeFilter())
                }
                .frame(maxWidth: .infinity)
                .disabled(text.isEmpty)
            }
            .padding()
            .navigationTitle("Add Filter")
            .buttonStyle(.bordered)
        }
    }
    
    func makeFilter() -> Filter {
        switch filterType {
        case .contains: return ContainsFilter(text: text)
        case .doesntContain: return DoesntContainFilter(text: text)
        }
    }
    
    enum FilterType: String, CaseIterable, Identifiable {
        case contains
        case doesntContain
        
        var id: String { title }
        
        var title: String {
            switch self {
            case .contains: return "Contains"
            case .doesntContain: return "Doesn't Contain"
            }
        }
    }
}

