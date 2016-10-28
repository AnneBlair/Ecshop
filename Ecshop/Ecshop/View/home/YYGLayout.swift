//
//  YYGLayout.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/24.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

/// 设置代理
protocol settingLayout {
    func settingLayout(layout: YYGLayout ,heigtWithWidth: Int,indexPath:NSIndexPath ) -> Int
}

class YYGLayout: UICollectionViewLayout {
    
    ///代理
    var delegate: settingLayout?
    /// 列的个数
    var columns: Int = 8
    /// 列与列之间的距离
    let columnsSpace: Int = 5
    /// 行与行直接的距离
    let rowSpace: Int = 5
    /// 存放每一类的最大y坐标
    var maxYDict: NSMutableDictionary = [:]
    /// 存放每列的宽度
    var cellWidth: Int?

    
    /**
     *   系统在开始计算每一个cell坐标之前调用，做一些初始化的工作
     */
    override func prepare() {
        let collectionViewWidth: Int = Int((self.collectionView?.bounds.size.width)!) - (columns - 1) * columnsSpace
        //在列数为columns的时候每个cell的宽度
        cellWidth = collectionViewWidth / columns
    }
    
    /**
     *  计算所有cell的frame
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        for i in 0..<columns {
            maxYDict[i] = 0
            printLogDebug(maxYDict)
        }
        
        var arr: [UICollectionViewLayoutAttributes] = []
        let num: NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        printLogDebug(num)
        for i in 0..<num {
            let path: IndexPath = IndexPath.init(item: i, section: 0)
            let attribute: UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: path)!
            arr.append(attribute)
        }
        printLogDebug(arr)
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
        let cellX: Int = (cellWidth! + columnsSpace) * minYColumn
        let cellH: Int = (delegate?.settingLayout(layout: self, heigtWithWidth: cellWidth!, indexPath: indexPath as NSIndexPath))!
        //记录列相应的其最大Y坐标值
        maxYDict[minYColumn] = Int(cellY) + rowSpace + cellH
        let attribute: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attribute.frame = CGRect.init(x: CGFloat(cellX), y: cellY, width: CGFloat(cellWidth!), height: CGFloat(cellH))
        printLogDebug(attribute)
        return attribute
        
    }
    /**
     *  得到布局好后，得到collectionview实际的大小
     */
    override var collectionViewContentSize: CGSize {
        var minYColumn: Int = 0
        maxYDict.enumerateKeysAndObjects ({ (columnIndex, maxY, stop) -> Void in
            if (maxYDict[minYColumn] as! CGFloat > maxYDict[columnIndex as! Int] as! CGFloat) {
                minYColumn = columnIndex as! Int
            }
        })
        printLogDebug(maxYDict)
        printLogDebug(maxYDict[minYColumn])
        var size: CGSize?
        if maxYDict[minYColumn] != nil {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height:  maxYDict[minYColumn] as! CGFloat)
        } else {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height: 100)
        }
        return size!
    }

}
