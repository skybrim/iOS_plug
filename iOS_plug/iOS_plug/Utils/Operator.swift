//
//  Operator.swift
//  iOS_plug
//
//  Created by wiley on 2020/7/20.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

// ?? 操作符的两边的参数必须类型匹配
// 扩展 ??? 操作符，左侧可选类型 T?，右侧字符串类型，方便打印
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


//将强制解包的报错信息生成 log
infix operator !!
func !!<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped { return x }
    fatalError(failureText())
}


// debug 版本中触发断言，release 版本返回默认值
// Int(foo) !? (99, "Expected integer")
infix operator !?
func !?<T>(wrapped: T?, nilDefault: @autoclosure () -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}
