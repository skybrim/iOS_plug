//
//  ViewController.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/26.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for _ in 0 ..< 10 {
            URLSessionClient().send(ExampleRequest(path: "json1")) { (result) in
                switch result {
                    case .success(let model):
                        print(model)
                    case .failure(let error):
                        print(error)
                }
            }
            
//            URLSessionClient().send(ExampleRequest(path: "json2")) { (result) in
//                switch result {
//                    case .success(let model):
//                        print(model)
//                    case .failure(let error):
//                        print(error)
//                }
//            }
        }
        

    }
}

struct ExampleRequest: RequestProtocol {
    var path: String
    var method: HTTPMethod = .GET
    var parameters: [String : Any]?
    var headers: [String : String]?
    
    typealias Response = ExampleModel
}

class URLSessionClient: ClientProtocol {
    var host: String = "https://gitee.com/throughskybrim/json/raw/master/"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionTask?
    
    func send<T: RequestProtocol>(_ request: T, completion: @escaping (Result<T.Response, Error>) -> Void) {
        dataTask?.cancel()
        
        guard let url = URL(string: host + request.path) else {
            DispatchQueue.main.async {
                completion(.failure(ClientError.InvaldURL))
            }
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let parseResult = T.Response.parse(data: data)
                switch parseResult {
                case .success(let model):
                    completion(.success(model))
                case .failure(let parseError):
                    completion(.failure(parseError))
                }
            } else {
                completion(.failure(ClientError.InvalidResponse))
            }
        }
        dataTask?.resume()
    }
}
