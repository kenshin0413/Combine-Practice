//
//  Fruit.swift
//  MyCombine
//
//  Created by miyamotokenshin on R 7/11/19.
//

import Foundation

struct Fruit: Identifiable {
    var id = UUID()
    var name: String
}
// CaseIterableを使うことでallCasesで書ける
enum SortOption: String, CaseIterable {
    case nameAsc = "前順"      // あいうえお順
    case nameDesc = "後順"    // 逆順
    case length = "文字数順"
}
