//
//  homeViewController.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/20.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

class homeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var dataSource: NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        let layout:  UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 128, height: 128)
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let rect: CGRect = UIScreen.main.bounds
        printLogDebug(rect)
        printLogDebug(UIScreen.main.bounds)
        let cvc: UICollectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        cvc.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "water")
        cvc.delegate = self
        cvc.dataSource = self
        self.view.addSubview(cvc)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //解析数据
    func loadData() {
        dataSource = NSMutableArray.init()
        //根据路径读取文件
        let path: String = Bundle.main.path(forResource: "water.plist", ofType: nil)!
        let arr: NSArray = NSArray(contentsOfFile: path)!
        for dict in arr {
            let model: YYGhomeModel = YYGhomeModel.init(dict: dict as! NSDictionary)
            dataSource?.add(model)
        }
    }
//
//    /// 代理行为
//    ///
//    /// - parameter layout:         YYGlayout
//    /// - parameter heigtWithWidth: 实际cell的宽度
//    /// - parameter indexPath:      具体cell的信息
//    ///
//    /// - returns: 返回处理后的实际高度
//    @objc func settingLayout(layout: YYGLayout, heigtWithWidth: Int, indexPath: NSIndexPath) -> CGFloat {
//        let model: YYGhomeModel = dataSource![indexPath.row] as! YYGhomeModel
//        return CGFloat(heigtWithWidth) * CGFloat(model.h!) * 1.0 / CGFloat(model.w!)
//    }
    
    //代理
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "water", for: indexPath)
        
        cell.backgroundColor = UIColor.purple
        return cell
        
    }

    

}
