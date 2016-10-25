//
//  YYGhomeModel.swift
//  Ecshop
//
//  Created by 区块国际－yin on 16/10/25.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit

class YYGhomeModel: NSObject {
    var h: Int?
    var w: Int?
    var image: String?
    var price: String?
    
    required init(dict: NSDictionary) {
        w = (dict["w"] as! Int)
        h = (dict["h"] as! Int)
        image = (dict["img"] as! String)
        price = (dict["price"] as! String)
    }
    
    func cellModel(withDict dict: NSDictionary) -> Self {
        
        let result = type(of: self).init(dict: dict)
        
        return result
    }
    

    
    
    
}
