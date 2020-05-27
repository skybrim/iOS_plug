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
                        print(model.message)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

