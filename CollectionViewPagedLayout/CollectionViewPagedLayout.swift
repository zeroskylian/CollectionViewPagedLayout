//
//  CollectionViewPagedLayout.swift
//  SwiftTs
//
//  Created by Xinbo Lian on 2020/12/8.
//

import UIKit

class CollectionViewPagedLayout: UICollectionViewFlowLayout {
    
    var row : Int = 2
    
    var column : Int = 4
    
    private var allAttributes : [UICollectionViewLayoutAttributes] = []
    
    
    override func prepare() {
        
        /// 一定要放在前面 ? 为啥呢
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        headerReferenceSize = .zero
        
        super.prepare()
        
        guard let count = collectionView?.numberOfItems(inSection: 0) else { return }
        for i in 0 ..< count {
            let indexPath = IndexPath(item: i, section: 0)
            guard let attribute = self.layoutAttributesForItem(at: indexPath) else { continue }
            allAttributes.append(attribute)
        }
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let item = indexPath.item
        var x :Int = 0
        var y : Int = 0
        
        targetPosition(item: item, x: &x, y: &y)
        let item2 = originItem(x: x, y: y)
        let newIndexPath = IndexPath(item: item2, section: indexPath.section)
        let newAttr = super.layoutAttributesForItem(at: newIndexPath)
        newAttr?.indexPath = indexPath
        return newAttr
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let attributes = super.layoutAttributesForElements(in: rect)  else {
            return nil
        }
        var tmp : [UICollectionViewLayoutAttributes] = []
        for attr in attributes {
            for attr2 in allAttributes {
                if attr.indexPath.item == attr2.indexPath.item {
                    tmp.append(attr2)
                    break
                }
            }
        }
        
        return tmp
    }
    
    override var collectionViewContentSize: CGSize
    {
        guard let collectionView = self.collectionView else {
            return super.collectionViewContentSize
        }
        let width = ceil(CGFloat(allAttributes.count) / CGFloat(row * column)) * collectionView.frame.size.width
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    
    private func targetPosition(item: Int , x :inout Int,  y :inout Int)
    {
        let page = item / ( column * row)
        let calX = item % column + page * column
        let calY = item / column - page * row
        x = calX
        y = calY
    }
    
    private func originItem(x : Int, y :Int) -> Int
    {
        x * row + y
    }
    
}
