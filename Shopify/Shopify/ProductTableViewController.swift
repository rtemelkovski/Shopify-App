//
//  ProductTableViewController.swift
//  Shopify
//
//  Created by Roberto Temelkovski on 2017-12-18.
//  Copyright © 2017 Roberto Temelkovski. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ProductTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    //MARK: UI Components
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    var products = [Product]()
    var filteredProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up Return key on search bar and back button on nav bar
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.backBarButtonItem?.title = "Back"
        
        // Load Sample Data into the table and refresh
        self.loadSampleData() {(err : Error?) -> Void in
            if let msg = err {
                fatalError(msg.localizedDescription);
            }
            self.filterContents(searchText: "")
            self.tableView.reloadData();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
            as? ProductTableViewCell else {
                fatalError("The dequeued cell is not a Product Cell.")
        }
        
        let product = filteredProducts[indexPath.row]
        
        cell.productTitleLabel.text = product.title
        cell.productDescText.text = product.desc

        // Load image for the cell if not already loaded
        Alamofire.request(product.image).responseImage { response in
            
            if let image = response.result.value {
                cell.productImage.image = image;
            }
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get all the important information out of the segue, anything that is incorrect, fail the application
        guard let sId = segue.identifier else{
            fatalError("This segue has no identifier...")
        }
        
        guard sId == "ShowProduct" else {
            fatalError("This is an invalid segue, cannot perform operation")
        }
        
        guard let vCtrl = segue.destination as? ProductViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let vCell = sender as? ProductTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: vCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        // Load in the image and product into the next view
        let selected = filteredProducts[indexPath.row]
        vCtrl.image = vCell.productImage.image
        vCtrl.product = selected
    }
    
    //MARK: Search Bar Functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
            filteredProducts = products;
            return;
        }
        
        self.filterContents(searchText: text)
        self.tableView.reloadData();
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.filterContents(searchText: "")
        self.tableView.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.text = nil
        searchBar.endEditing(true)
    }
    
    //MARK: Private Functions
    
    private func filterContents(searchText: String) {
        if searchText.isEmpty{
            filteredProducts = products
            return;
        }
        
        self.filteredProducts = self.products.filter({( prod: Product) -> Bool in
            return prod.title.lowercased().range(of: searchText.lowercased()) != nil
        })
    }
    
    private func loadSampleData(completion: @escaping (Error?) -> Void) {
        print("Loading sample data...")
        let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        Alamofire.request(url).responseData { (resData) -> Void in
            guard let data = resData.result.value else {
                return;
            }
            
            let json = JSON(data)
            
            if let prodLst = json["products"].arrayObject as? [[String:AnyObject]]{
                self.products = prodLst.map({ (prod: [String:AnyObject]) -> Product in
                    // Perform checks for all the mandatory fields
                    guard let id = prod["id"] as? Int else {
                        fatalError("This entry has no id.")
                    }
                    
                    guard let title = prod["title"] as? String else{
                        fatalError("This entry has no title.")
                    }
                    
                    guard let desc = prod["body_html"] as? String else{
                        fatalError("this entry has no desc.")
                    }
                    
                    guard let images = prod["images"] as? [[String:AnyObject]],
                        let url = images[0]["src"] as? String else{
                            fatalError("This entry has no image.")
                    }
                    
                    // Return Product
                    return Product(id: id, title: title, image: url, desc: desc,
                                   vendor: (prod["vendor"] as? String?)!,
                                   productType: (prod["product_type"] as? String?)!,
                                   tags: (prod["tags"] as? String?)!)
                });
            }
            // Completion handler
            completion(nil);
        }
    }
}
