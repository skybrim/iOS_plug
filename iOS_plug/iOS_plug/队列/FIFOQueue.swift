//
//  FIFOQueue.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/16.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

//先展示一个简单的先进先出队列
struct FIFOQueue<Element> {
    private var left: [Element] = []
    private var right: [Element] = []

    // 将元素添加到队列最后 O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }

    // 从队列前端移除一个元素，队列为空时返回 nil O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

// 遵循 collection 协议
extension FIFOQueue: Collection {
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }

    public func index(after i: Int) -> Int {
        precondition( i >= startIndex && i < endIndex, "Index out of bounds")
        return i + 1
    }

    /*
     // 下标方法放在了下面 MutableCollection 扩展中
    public subscript(position: Int) -> Element {
        precondition((startIndex..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
    */
}
// 支持原地的元素修改
extension FIFOQueue: MutableCollection {
    public subscript(position: Int) -> Element {
        get {
            precondition((0..<endIndex).contains(position), "Index out of bounds")
            if position < left.endIndex {
                return left[left.count - position - 1]
            } else {
                return right[position - left.count]
            }
        }
        set {
            precondition((0..<endIndex).contains(position), "Index out of bounds")
            if position < left.endIndex {
                left[left.count - position - 1] = newValue
            } else {
                return right[position - left.count] = newValue
            }
        }
    }
}

// 字面量创建队列
// let foo: FIFOQueue = [1, 2, 3]
extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(left:elements.reversed(), right:[])
    }
}


