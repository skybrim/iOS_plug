//
//  ExampleFallViewController.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/27.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class ExampleFallViewController: UIViewController {
    
    // MARK: Class Variable Definitions
    
    fileprivate var dataArray: [FallModel] = []
    
    fileprivate let FallCell = "FallCell"

    lazy var fall: UICollectionView = {
        let fallLayout = UICollectionViewFallLayout()
        fallLayout.delegate = self
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: fallLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: FallCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subview layout
        addSubviews()
        addViewConstraints()
        
        // create data
        dataArray = createData()
        fall.reloadData()
    }
    
    // MARK: Subview Layout Functions
    
    func addSubviews() {
        view.addSubview(fall)
    }
    
    func addViewConstraints() {
        fall.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fall.topAnchor.constraint(equalTo: self.view.topAnchor),
            fall.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            fall.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            fall.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

// MARK:- UICollectionViewFallLayoutDelegate

extension ExampleFallViewController: UICollectionViewFallLayoutDelegate {

    func fallLayout(_ fallLayout: UICollectionViewFallLayout, width: CGFloat, heightForIndexPath: IndexPath) -> CGFloat {
        let data = dataArray[heightForIndexPath.item]
        return data.height
    }
}

// MARK:- UICollectionViewDataSource

extension ExampleFallViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FallCell, for: indexPath) as! LabelCollectionViewCell
        let data = dataArray[indexPath.item]
        cell.textLabel.text = String(indexPath.item)
        cell.contentView.backgroundColor = UIColor(hex6: UInt32(data.color))
        return cell
    }
}

// MARK:- UICollectionViewDelegate

extension ExampleFallViewController: UICollectionViewDelegate {
    
}

// MARK:- Data

extension ExampleFallViewController {
    
    func createData() -> [FallModel] {
        let colorArray = [0xff0000, 0x00ff00, 0x0000ff]
        var dataArray = [FallModel]()
        for _ in 0..<100 {
            let model = FallModel(color: colorArray[Int(arc4random()%3)], height: CGFloat(arc4random()%50)+50)
            dataArray.append(model)
        }
        return dataArray
    }
}

// MARK:- Model

struct FallModel: Parsable {
    let color: Int
    let height: CGFloat
}

// MARK:- View

class LabelCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
