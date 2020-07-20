//
//  Utils.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/20.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation


// 左侧可选类型 T?，右侧字符串类型，方便打印
// print("temperature: \(temperature ??? "NaN")")
infix operator ???: NilCoalescingPrecedence
public func ???<T>(optional: T?, defaultValue:@autoclosure () -> String) -> String {
    
    switch optional {
    case let value?:
        return String(describing: value)
    case nil:
        return defaultValue()
    }
}
