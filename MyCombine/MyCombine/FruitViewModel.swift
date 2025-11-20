//
//  FruitViewModel.swift
//  MyCombine
//
//  Created by miyamotokenshin on R 7/11/19.
//

import Foundation
import Combine

class FruitViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredFruits: [Fruit] = []
    @Published var sortOption: SortOption = .nameAsc
    var allFruits: [Fruit] = [Fruit(name: "banana"), Fruit(name: "apple"), Fruit(name: "orange")]
    
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        Publishers.CombineLatest($searchText, $sortOption)
        // 入力が止まってから0.3秒後に処理
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { [weak self] text, option -> [Fruit] in
                guard let self else { return [] }
                let lower = text.lowercased()
                var result = self.allFruits
                if !lower.isEmpty {
                    result = result.filter { $0.name.lowercased().contains(lower) }
                }
                
                switch option {
                case .nameAsc:
                    result.sort { $0.name.lowercased() < $1.name.lowercased() }
                case .nameDesc:
                    result.sort { $0.name.lowercased() > $1.name.lowercased() }
                case .length:
                    result.sort { $0.name.count < $1.name.count }
                }
                return result
            }
            .assign(to: &$filteredFruits)
    }
}
