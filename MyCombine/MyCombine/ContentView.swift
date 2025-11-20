//
//  ContentView.swift
//  MyCombine
//
//  Created by miyamotokenshin on R 7/11/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fruitVM = FruitViewModel()
    var body: some View {
        VStack {
            TextField("検索", text: $fruitVM.searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Picker("並び替え", selection: $fruitVM.sortOption) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            List {
                ForEach(fruitVM.filteredFruits) { fruits in
                    Text(fruits.name)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
