//
//  ItemDetailViewController.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var incrementDecrementLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemCalLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    
    var items: Items!
    var price = 0.0
    var constantPrice = 0.0
    var itemCount = 1
    var itemName = ""
    var titleName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl.text = titleName
        self.setItemData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setItemData(){
        self.incrementDecrementLbl.text = "1"
        if let itemImage = items.image{
            self.itemImageView.image = UIImage(named: itemImage)
        }
        if let itemName = items.name{
            self.itemName = itemName
            if let itemPrice = items.price{
                self.itemNameLbl.text = "\(itemName) - $\(itemPrice)"
                self.price = Double(itemPrice)!
                self.constantPrice = Double(itemPrice)!
                
            }else{
                self.itemNameLbl.text = "\(itemName)"
            }
           
        }
        
        if let itemCal = items.cal{
            self.itemCalLbl.text = itemCal
        }
        
        if let itemDesc = items.description{
            self.itemDescLbl.text = itemDesc
        }
    }
   
    @IBAction func didTapBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapIncrementDecrementBtn(_ sender: UIButton) {
        
        if sender.tag == 0{
            itemCount += 1
        }else{
            if itemCount != 1{
                itemCount -= 1
            }
        }
        self.incrementDecrementLbl.text = "\(itemCount)"
        self.price = self.constantPrice * Double(itemCount)
        self.itemNameLbl.text = "\(self.itemName) - $\(price.rounded(digits: 2))"
        
    }
    
}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
