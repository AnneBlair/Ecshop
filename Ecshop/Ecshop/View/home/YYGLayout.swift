//
//  YYGLayout.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/24.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

/// 设置代理
@objc protocol RequestHandler {
    @objc optional func settingLayout(layout: YYGLayout ,heigtWithWidth: Int,indexPath:NSIndexPath ) -> CGFloat
}

class YYGLayout: UICollectionViewLayout {
    
    /// 列的个数
    let columns: Int = 2
    /// 列与列之间的距离
    let columnsSpace: Int = 5
    /// 行与行直接的距离
    let rowSpace: Int = 5
    /// 存放每一类的最大y坐标
    var maxYDict: NSMutableDictionary?
    /// 存放没列的宽度
    var cellWith: Int?
    
    
    /**
     *   系统在开始计算每一个cell坐标之前调用，做一些初始化的工作
     */
    override func prepare() {
        let collectionViewWidth: Int = Int((self.collectionView?.bounds.size.width)!) - (columns - 1) * columnsSpace
        cellWith = collectionViewWidth/columns
    }
    
    /**
     *  计算所有cell的frame
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        for i in 0..<columns {
            maxYDict?[i] = 0
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
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        
//    }
    
    
    
    
    
}
