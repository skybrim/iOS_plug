//
//  UICollectionViewFallLayout.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/27.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

protocol UICollectionViewFallLayoutProtocol {
    
}

class UICollectionViewFallLayout: UICollectionViewLayout {
    
    var attributesArray: [UICollectionViewLayoutAttributes]?
    
    // 由于瀑布流导致的尺寸变化我们重写 contentSize。
    // 其中宽度一般情况我们是可以确定的，它取决于每个item的宽度，一行几个 item，以及 contentInset 值。
    // 高度我们可以先设定为 0，之后在 prepare() 里进行更新。
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: 0, height: 100)
        }
    }
    
    // 该方法发生在 UICollectionView 数据准备好，但界面还未布局之时。
    // 它用于计算各种布局信息，并设定每个 item 的相关属性。
    // 这里我们用横纵坐标轴分别进行计算每个 cell 的 xOffset 和 yOffset，然后将其转化为相应的 frame 并缓存起来。
    override func prepare() {
        super.prepare()
        
        if let itemCount = collectionView?.numberOfItems(inSection: 0)
        for item in itemCount {
            
        }
    }
    
    // prepare() 完成布局之后该方法被调用，它决定了哪些 item 在 CollectionView 给定的区域内可见。
    // 我们只要取交集（intersect）即可。
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    // 该方法需要我们针对每一个 item 设定 layoutAttribute。
    // 由于我们在 prepare() 中已经完成相应计算，此时只需返回对应 indexPath 的特定属性即可。
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
}
