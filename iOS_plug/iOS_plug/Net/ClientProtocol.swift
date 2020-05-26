//
//  ClientProtocol.swift
//  v2ex
//
//  Created by wiley on 2019/12/23.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

enum ClientError: Error {
  case InvaldURL
  case InvalidResponse
}

// MARK: - Client
protocol ClientProtocol {
    var host: String { get }

    func send<T: RequestProtocol>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void)
}
