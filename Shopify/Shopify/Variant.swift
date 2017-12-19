//
//  Variant.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-19.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import Foundation

class Variant {
    
    //MARK: Properties
    var id: Int
    var title: String
    var price: Double?
    var quantity: Int
    
    init(id: Int, title: String, price: Double?, quantity: Int){
        self.id = id
        self.title = title
        self.price = price
        self.quantity = quantity
    }
    
}
