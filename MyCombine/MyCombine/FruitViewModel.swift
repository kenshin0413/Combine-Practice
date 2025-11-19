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
    var allFruits: [Fruit] = [Fruit(name: "banana"), Fruit(name: "apple"), Fruit(name: "orange")]
    var cancellables = Set<AnyCancellable>()
    
    init() {
        filteredFruits = allFruits
        
        $searchText
        // 入力が止まってから0.3秒後に処理
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        // 前回と同じ文字列なら処理しない
            .removeDuplicates()
        
            .map { text in
                text
                // searchTextを小文字に変換
                .lowercased()
                // 空白除去
                .trimmingCharacters(in: .whitespaces)
            }
                // 条件に応じて絞り込む
                    .sink { [weak self] text in
                        // selfがnilかnilじゃないか
                        // viewModelが破棄されてないかの判定
                        guard let self else { return }
                        self.filteredFruits = text.isEmpty
                        ? self.allFruits
                        // .containsは含んでるかを判定
                        : self.allFruits.filter { $0.name.lowercased().contains(text) }
                    }
                    .store(in: &cancellables)
            }
    }
