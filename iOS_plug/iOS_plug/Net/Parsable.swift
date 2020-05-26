//
//  Parsable.swift
//  v2ex
//
//  Created by wiley on 2019/12/23.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

/// Parse
protocol Parsable: Decodable {
    static func parse(data: Data) -> Result<Self, Error>
}

/// 同时遵循 Decodable 和 Parsable ，扩展方法
extension Parsable {
    
    static func parse(data: Data) -> Result<Self, Error> {
        do {
            let model = try JSONDecoder().decode(Self.self, from: data)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}

/// # Array 条件遵循
/// 当 Array 里的元素遵循 Parsable 时，Array 也遵循 Parsable 协议
extension Array: Parsable where Array.Element: Parsable {}
