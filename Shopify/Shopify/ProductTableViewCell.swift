//
//  ProductTableViewCell.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-18.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
