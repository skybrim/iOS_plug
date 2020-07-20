//
//  Array+Additions.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/20.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

extension Array {
    // 累加，将所有元素合并到一个数组，保留合并时每一步的值
    // [1, 2, 3, 4].accumulate(0, +) // [1, 3, 6, 10]
    func accumulate<Result>(_ initialResult: Result,
                            _ nextPartialResult:(Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    // 计算满足条件的元素的个数
    func count(where predicate: (Element) -> Bool) -> Int {
        var result = 0
        for element in self {
            if predicate(element) { result += 1 }
        }
        return result
    }
    
    // 返回一个满足某个条件的所有元素的索引列表
    func indices(where predicate: (Element) -> Bool) -> [Int] {
        var result = [Int]()
        for (index, element) in self.enumerated() {
            if predicate(element) { result.append(index) }
        }
        return result
    }
}

extension Array {
    // 通过索引值从数组中返回 Optional 对象
    // var foo = array[guarded: 3]  ?? 0
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
