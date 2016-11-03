//
//  homeViewController.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/20.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

class homeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,settingLayout {

    
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var layout: YYGLayout!
    @IBOutlet weak var cvc: UICollectionView!
    
    var dataSource: NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLayout()
        loadData()
        layout.delegate = self
        cvc.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "water")
        
        
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
    
    func loadLayout() {
        self.title = "三界生活"
        cvc.addSubview(headView)
    }

    /// 代理行为
    ///
    /// - parameter layout:         YYGlayout
    /// - parameter heigtWithWidth: 实际cell的宽度
    /// - parameter indexPath:      具体cell的信息
    ///
    /// - returns: 返回处理后的实际高度
    func settingLayout(layout: YYGLayout, heigtWithWidth: Int, indexPath: NSIndexPath) -> Int {
        let model: YYGhomeModel = dataSource![indexPath.row] as! YYGhomeModel
        return (heigtWithWidth * model.h! * 1 / model.w!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else if section == 1 {
            return 4
        }
        else {
            return 24
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "water", for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        printLogDebug("点了了\(indexPath.row)")
    }
    


    

}
