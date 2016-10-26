//
//  YYGLayout.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/24.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

/// 设置代理
@objc protocol settingLayout {
    @objc optional func settingLayout(layout: YYGLayout ,heigtWithWidth: Int,indexPath:NSIndexPath ) -> CGFloat
}

class YYGLayout: UICollectionViewLayout {
    
    ///代理
    weak var delegate: settingLayout!;
    /// 列的个数
    let columns: Int = 2
    /// 列与列之间的距离
    let columnsSpace: Int = 5
    /// 行与行直接的距离
    let rowSpace: Int = 5
    /// 存放每一类的最大y坐标
    var maxYDict: NSMutableDictionary = [:]
    /// 存放没列的宽度
    var cellWidth: Int?
    
    
    /**
     *   系统在开始计算每一个cell坐标之前调用，做一些初始化的工作
     */
    override func prepare() {
        let collectionViewWidth: Int = Int((self.collectionView?.bounds.size.width)!) - (columns - 1) * columnsSpace
        cellWidth = collectionViewWidth/columns
    }
    
    /**
     *  计算所有cell的frame
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        for i in 0..<columns {
            maxYDict[i] = 0
        }
        var arr: [UICollectionViewLayoutAttributes]?
        let num: NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        
        for i in 0..<num {
            let path: NSIndexPath = NSIndexPath.init(item: i, section: 0)
            let attribute: UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: path as IndexPath)!
            arr?.append(attribute)
        }
        return arr
    }
    
    /**
     *  计算某一个cell的frame
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var minYColumn: Int = 0
        maxYDict.enumerateKeysAndObjects({ (columnIndex, maxY,stop ) -> Void in
            if (self.maxYDict[minYColumn] as! Float) > (self.maxYDict[columnIndex] as! Float){
                minYColumn = columnIndex as! Int
            }
        })
        
        let cellY: CGFloat = maxYDict[minYColumn] as! CGFloat
        let cellX: Int = cellWidth! + columnsSpace
        
        
        let cellH: CGFloat = (delegate?.settingLayout?(layout: self, heigtWithWidth: cellWidth!, indexPath: indexPath as NSIndexPath))!
        maxYDict[minYColumn] = Int(cellY) + rowSpace + Int(cellH)
        let attribute: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.frame = CGRect.init(x: CGFloat(cellX), y: cellY, width: CGFloat(cellWidth!), height: cellH)
        return attribute
        
    }
    
    /**
     *  得到布局好后，collectionview实际的大小
     */
    override var collectionViewContentSize: CGSize {
        var minYColumn: Int = 0
        maxYDict.enumerateKeysAndObjects ({ (columnIndex, maxY, stop) -> Void in
            if maxYDict[minYColumn] as! CGFloat > maxYDict[columnIndex as! Int] as! CGFloat  {
                minYColumn = columnIndex as! Int
                stop.pointee = true
            }
        })
        
        printLogDebug(maxYDict)
        printLogDebug(maxYDict[minYColumn])
        var size: CGSize?
        if maxYDict[minYColumn] != nil {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height:  maxYDict[minYColumn] as! CGFloat)
        } else {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height: 0)
        }
        
    
        return size!
    }

}
