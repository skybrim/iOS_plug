//
//  Example.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/27.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

/// Model
struct ExampleModel: Parsable {
    let name: String
    let message: String
}

/// Request
struct ExampleRequest: RequestProtocol {
    var path: String = "json1"
    var method: HTTPMethod = .GET
    var parameters: [String : Any]?
    var headers: [String : String]?
    
    typealias Response = ExampleModel
}

/// 使用 URLSession 实现的 Client，也可以使用 AF、AL 等实现
struct URLSessionClient: ClientProtocol {
    var host: String = "https://gitee.com/throughskybrim/json/raw/master/"
    
    func send<T: RequestProtocol>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        
        guard let url = URL(string: host + request.path) else {
            DispatchQueue.main.async {
                completion(.failure(ClientError.InvaldURL))
            }
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    let parseResult = T.Response.parse(data: data)
                    switch parseResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let parseError):
                        completion(.failure(parseError))
                    }
                }
            } else {
                completion(.failure(ClientError.InvalidResponse))
            }
        }
        dataTask.resume()
    }
}

