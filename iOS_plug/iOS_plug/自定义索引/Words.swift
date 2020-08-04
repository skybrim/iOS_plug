//
//  Words.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/16.
//  Copyright © 2020 wiley. All rights reserved.
//

/*
/ 分割集合类型，split方法通常最合适，但是这个方法会计算整个数组。
/ 如果数组很大，但是只需要前几个元素，这样做效率低。
/ 现在针对集合类型 String(英文)
/ 目标是，构建一个 words 集合，它能够让我们不一次性计算出所有单词，而是可以用延迟加载的方式进行迭代。
*/

/*
 使用：
 
 Array(Words("hello world test")) // ["hello", "world", "test"]

 Array(Words("Hello world test").prefix(2)) // ["h
 
*/

import Foundation

// MARK:-
// 首先，从 SubString 中寻找第一个单词的范围。
// 使用空格作为单词的边界
extension Substring {
    var nextWordRange: Range<Index> {
        // 移除所有前置的空格
        let start = drop(while: { $0 == " "} )
        // 寻找结束空格，如果没有，则使用 endIndex
        let end = start.firstIndex(where: { $0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
}

// MARK:-
// 其次，定义索引的类型。
// 通过索引下标访问某个元素，应该是一个 O(1) 的操作，因此封装 Range<Substring.Index> 来作为索引类型。
// 索引类型需要满足 Comparable(继承自 Equatable)，此时我们采用 range 的下边界作为比较对象。
struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>

    fileprivate init(_ value: Range<Substring.Index>) {
        self.range = value
    }

    static func <(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }

    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}

// MARK:-
// 第三，构建 Words 集合类型。
// 在底层将 String 视为 SubString 存储；
// 提供两个属性： startIndex 、 endIndex；
// 同时，需要遵循 Collection 协议，并实现 subscript 下标方法。
struct Words {
    let string: Substring
    let startIndex: WordsIndex
    public var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }

    init(_ s: String) {
        self.init(s[...])
    }

    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
}

extension Words {
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
}

extension Words: Collection {
    public func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else {
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

// MARK:-
// 切片
// 优先考虑能否使用其本身作为自己的 SubSequence 使用
// 重载 subscript(range:Range<Index>)
extension Words {
    // 重载切片操作的实现
    subscript(range:Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}
