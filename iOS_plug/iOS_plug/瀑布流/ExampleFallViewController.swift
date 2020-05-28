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
    
    fileprivate let FallCell = "FallCell"

    lazy var fall: UICollectionView = {
        let fallLayout = UICollectionViewFallLayout()
        fallLayout.delegate = self
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: fallLayout)
        collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: FallCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        addViewConstraints()
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
        return 0
    }
}

// MARK:- UICollectionViewDataSource

extension ExampleFallViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FallCell, for: indexPath) as! LabelCollectionViewCell
        cell.textLabel.text = String(indexPath.item)
        return cell
    }
}

// MARK:- UICollectionViewDelegate

extension ExampleFallViewController: UICollectionViewDelegate {
    
}

// MARK:- Data

extension ExampleFallViewController {
    
    func createData() -> String {
        let colorArray = ["0xff0000", "0x00ff00", "0x0000ff"]
        return ""
    }
}

// MARK:- Model

struct FallModel: Parsable {
    let color: String
    let height: CGFloat
}

// MARK:- View

class LabelCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let red = UIColor(named: "red")

        backgroundColor = red
        
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
