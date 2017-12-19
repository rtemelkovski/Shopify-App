//
//  UIImageView.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-18.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(url: url as URL)
            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.mainQueue()) {
                (response: URLResponse!, data: NSData!, error: NSError!) -> Void in
                self.image = UIImage(data: data)
            }
        }
    }
}
