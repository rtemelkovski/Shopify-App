//
//  Product.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-18.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    //MARK: Properties
    var id: Int
    var title: String
    var image: String
    var desc: String
    var vendor: String?
    var productType : String?
    var tags: String?
    
    
    init(id: Int, title: String, image: String, desc: String, vendor: String?, productType: String?, tags: String?){
        self.id = id;
        self.title = title;
        self.image = image;
        self.desc = desc;
        self.vendor = vendor;
        self.productType = productType;
        self.tags = tags;
    }
    
}
