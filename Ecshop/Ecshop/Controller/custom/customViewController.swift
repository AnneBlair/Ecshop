//
//  customViewController.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/20.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

class customViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.addRootControllerToTabBar(viewControll: homeViewController(), imageName: "hangq_01", selectImage: "hangq_02", title: "首页")
        self.addRootControllerToTabBar(viewControll: lifeViewController(), imageName: "hangq_01", selectImage: "hangq_02", title: "未来生活")
        self.addRootControllerToTabBar(viewControll: IMViewController(), imageName: "hangq_01", selectImage: "hangq_02", title: "客服")
        self.addRootControllerToTabBar(viewControll: shoppingViewController(), imageName: "hangq_01", selectImage: "hangq_02", title: "购物车")
        self.addRootControllerToTabBar(viewControll: personalViewController(), imageName: "hangq_01", selectImage: "hangq_02", title: "个人中心")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRootControllerToTabBar(viewControll: UIViewController,imageName: String,selectImage: String,title: String) {
    
        let nav: UINavigationController = UINavigationController.init(rootViewController: viewControll)
        let normalImage: UIImage = (UIImage.init(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!
        let selectImage: UIImage = (UIImage.init(named: selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!
        viewControll.tabBarItem = UITabBarItem.init(title: title, image: normalImage, selectedImage: selectImage)
        viewControll.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
        self.tabBar.tintColor = UIColor.clear
        self.addChildViewController(nav)
        
    }
}
