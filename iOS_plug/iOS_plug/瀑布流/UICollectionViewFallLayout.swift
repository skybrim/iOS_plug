//
//  UICollectionViewFallLayout.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/27.
//  Copyright © 2020 wiley. All rights reserved.
//

import UIKit

fileprivate let defaultColumnCount: Int = 3
fileprivate let defaultColumnMargin: CGFloat = 10
fileprivate let defaultRowMargin: CGFloat = 10
fileprivate let defaultEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10,
                                                               left: 10,
                                                               bottom: 10,
                                                               right: 10)

protocol UICollectionViewFallLayoutDelegate: class {
    var fallColumnCount: Int { get }
    var fallColumnMargin: CGFloat { get }
    var fallRowMargin: CGFloat { get }
    var fallEdgeInsets: UIEdgeInsets { get }
    
    func fallLayout(_ fallLayout: UICollectionViewFallLayout, width: CGFloat, heightForIndexPath: IndexPath) -> CGFloat
}

extension UICollectionViewFallLayoutDelegate {
    var fallColumnCount: Int {
        return defaultColumnCount
    }
    var fallColumnMargin: CGFloat {
        return defaultColumnMargin
    }
    var fallRowMargin: CGFloat {
        return defaultRowMargin
    }
    var fallEdgeInsets: UIEdgeInsets {
        return defaultEdgeInsets
    }
}

class UICollectionViewFallLayout: UICollectionViewLayout {
    
    // MARK: Class Variable Definitions
    
    // UICollectionViewFallLayoutDelegate
    weak var delegate: UICollectionViewFallLayoutDelegate?
    fileprivate var columnCount: Int {
        return self.delegate?.fallColumnCount ?? defaultColumnCount
    }
    fileprivate var columnMargin: CGFloat {
        return self.delegate?.fallRowMargin ?? defaultColumnMargin
    }
    fileprivate var rowMargin: CGFloat {
        return self.delegate?.fallRowMargin ?? defaultRowMargin
    }
    fileprivate var edgeInsets: UIEdgeInsets {
        return self.delegate?.fallEdgeInsets ?? defaultEdgeInsets
    }
    
    // 存放所有列的当前高度
    fileprivate var columnHeights: [CGFloat] = []
    // 存放 item 的 attributes 的数组
    fileprivate var attributesArray: [UICollectionViewLayoutAttributes] = []
    
    fileprivate var contentHeight: CGFloat = 0
    override var collectionViewContentSize: CGSize {
        CGSize(width: self.collectionView?.frame.width ?? 0, height: contentHeight)
    }
    
    // MARK: Class func

    override func prepare() {
        super.prepare()
        
        // 初始高度
        self.contentHeight = 0
        
        // 重置列高度数组
        self.columnHeights.removeAll()
        self.columnHeights = Array(repeating: edgeInsets.top, count: columnCount)
        
        // 重置 attributes 数组
        self.attributesArray.removeAll()
        if let itemCount = collectionView?.numberOfItems(inSection: 0) {
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: 0)
                if let attrs = layoutAttributesForItem(at: indexPath) {
                    self.attributesArray.append(attrs)
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        // 确定宽和高
        let width = calculateCellWidth()
        let height = self.delegate?.fallLayout(self, width: width, heightForIndexPath: indexPath) ?? 0
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        // 找到最短的一列
        var indexOfMinHeight: Int = 0
        var minHeight: CGFloat = 0.0
        if let min = columnHeights.min(),
            let index = columnHeights.firstIndex(of: min) {
            indexOfMinHeight = Int(index)
            minHeight = min
        }
        x = edgeInsets.left + (width + columnMargin) * CGFloat(indexOfMinHeight)
        y = minHeight
        if y != edgeInsets.top { y += rowMargin }
        
        // 赋值
        attrs.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // 更新高度数组
        let newHeight = attrs.frame.maxY
        self.columnHeights[indexOfMinHeight] = newHeight
        
        // 更新 contentSize 高度
        if contentHeight < newHeight {
            contentHeight = newHeight
        }

        return attrs
    }
    
    func calculateCellWidth() -> CGFloat {
        let collectionViewWidth = self.collectionView?.frame.width ?? 0
        let edgeWidth = edgeInsets.left + edgeInsets.right
        let marginWidth = columnMargin * CGFloat(columnCount - 1)
            
        return (collectionViewWidth - edgeWidth - marginWidth) / CGFloat(columnCount)
    }
    
}
