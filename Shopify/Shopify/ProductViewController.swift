//
//  ProductViewController.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-19.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductViewController: UIViewController {

    //MARK: UI Components
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!

    //MARK: Properties
    var product:Product?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = product?.title
        self.navigationItem.backBarButtonItem?.title = "Back"

        
        if let img = image {
            self.productImage.image = img;
        }
        
        guard let prod = product else {
            fatalError("Cannot open product page for no project...")
        }
        
        self.productDescription.text = prod.desc
        
        if let vendor = prod.vendor {
            self.vendorLabel.text = vendor
        }else{
            self.vendorLabel.text = "N/A"
        }
        
        if let prodType = prod.productType {
            self.productTypeLabel.text = prodType
        }else{
            self.productTypeLabel.text = "N/A"
        }
        
        if let tags = prod.tags {
            self.tagsLabel.text = tags
        }else{
            self.tagsLabel.text = "N/A"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
