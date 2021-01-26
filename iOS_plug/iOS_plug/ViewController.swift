//
//  ViewController.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/26.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let ShowFuncCell = "ShowFuncCell"

    lazy var show: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: ShowFuncCell)
        return tv
    }()
    
    var funcArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        funcArray = ["网络封装", "瀑布流", "调用栈"]
        
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(show)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ExampleNetViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(ExampleFallViewController(), animated: true)
        case 2:
            CallstackInfo.showAll();
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowFuncCell, for: indexPath)
        cell.textLabel?.text = funcArray?[indexPath.row] ?? "None"
        return cell
    }
}

