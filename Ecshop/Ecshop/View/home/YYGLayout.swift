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

class YYGLayout: UICollectionViewFlowLayout {
    
    ///代理
    var delegate: settingLayout?
    /// 列的个数
    var columns: Int = 2
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
            //初始化测CellY的开始坐标
            maxYDict[i] = 200
        }
        
        var arr: [UICollectionViewLayoutAttributes] = []
        
        let numSection: Int = (self.collectionView?.numberOfSections)!
        let num: NSInteger = (self.collectionView?.numberOfItems(inSection: 0))!
        for j in 0..<numSection {
            for i in 0..<num {
                let path: IndexPath = IndexPath.init(item: i, section: j)
                let attribute: UICollectionViewLayoutAttributes = self.layoutAttributesForItem(at: path)!
                arr.append(attribute)
            }
        }
        return arr
    }
    
    /**
     *  计算某一个cell的frame
     */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let Nowsection: sectionNum = sectionNum(rawValue: indexPath.section)!
        switch Nowsection {
        case .sectionNum1:
            printLogDebug("this 1") ///当是section为1 的时候执行
        case .sectionNum2:
            printLogDebug("this 2")
        case .sectionNum3:
            printLogDebug("this 3")
        case .sectionNum4:
            printLogDebug("this 4")
            
        }
        
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
        var size: CGSize?
        if maxYDict[minYColumn] != nil {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height:  maxYDict[minYColumn] as! CGFloat)
        } else {
            size = CGSize.init(width: (collectionView?.bounds.size.width)!, height: 0)
        }
        return size!
    }
    
    /// 根据拿到的列数，实时计算出其宽度
    ///
    /// - parameter listNum: 列数
    ///
    /// - returns: 根据得到的列数，返回其宽度
    func calculateCellWide(listNum: Int) -> Int {
        let collectionViewWidth: Int = Int((self.collectionView?.bounds.size.width)!) - (listNum - 1) * columnsSpace
        ///得到具体的列数返回cell 的宽度
        let realTimeWidth: Int = collectionViewWidth / listNum
        
        return realTimeWidth
    }

}
