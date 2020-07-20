//
//  Sequence+Addition.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/20.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

// 计算序列的频率
extension Sequence where Element: Hashable {
    var frequencies: [Element: Int] {
        return Dictionary(self.map {($0, 1)}, uniquingKeysWith: +)
    }
}

// 获取序列中所有唯一的元素
extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}
