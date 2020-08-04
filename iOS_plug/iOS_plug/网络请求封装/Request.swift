//
//  RequestProtocol.swift
//  v2ex
//
//  Created by wiley on 2019/12/20.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

// MARK: - request
/// # HTTP 方法枚举
enum HTTPMethod: String {
    case GET // 获取资源
    case POST // 传输实体主体
    case HEAD // 获得报文头部
    case PUT // 传输文件，不带验证
    case DELETE // 删除文件，不带验证
}

/// # 发起请求遵循 Request 协议
protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    associatedtype Response: Parsable
}
