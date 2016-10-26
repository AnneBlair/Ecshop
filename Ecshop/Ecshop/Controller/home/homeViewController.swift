//
//  homeViewController.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/20.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

class homeViewController: UIViewController ,settingLayout ,UICollectionViewDelegate,UICollectionViewDataSource{

    var dataSource: NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        let layout = YYGLayout()
        layout.delegate = self
        let collectionView: UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(YYGCollectionViewCell.self, forCellWithReuseIdentifier: "water")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
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
    
    /// 代理行为
    ///
    /// - parameter layout:         YYGlayout
    /// - parameter heigtWithWidth: 实际cell的宽度
    /// - parameter indexPath:      具体cell的信息
    ///
    /// - returns: 返回处理后的实际高度
    @objc func settingLayout(layout: YYGLayout, heigtWithWidth: Int, indexPath: NSIndexPath) -> CGFloat {
        let model: YYGhomeModel = dataSource![indexPath.row] as! YYGhomeModel
        return CGFloat(heigtWithWidth) * CGFloat(model.h!) * 1.0 / CGFloat(model.w!)
    }
    
    ///collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YYGCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "water", for: indexPath) as! YYGCollectionViewCell
//        var model: YYGhomeModel = dataSource[indexPath.row]
        cell.backgroundView?.backgroundColor = UIColor.red
        return cell
    }
    

}
