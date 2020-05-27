//
//  ExampleFallViewController.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/27.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

class ExampleFallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension ExampleFallViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ExampleFallViewController: UICollectionViewDelegate {
    
}


