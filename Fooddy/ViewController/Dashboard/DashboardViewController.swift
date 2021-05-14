//
//  DashboardViewController.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class DashboardViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var subMenuTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    var selectedItem = 0
    var menus: Menu!
    var subCategories: [SubCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuCollectionView.register(UINib(nibName:"MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        self.subMenuTableView.register(UINib(nibName:"SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier:"SubMenuTableViewCell")
        //self.menuCollectionView?.collectionViewLayout = columnLayout
        self.getJsonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func getJsonData(){
        guard let path = Bundle.main.path(forResource: "Menu", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
           // let json = try JSON(data: data)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
               
                if let menu = Mapper<Menu>().map(JSONObject: json){
                    self.menus = menu
                    
                    DispatchQueue.main.async {
                        self.menuCollectionView.reloadData()
                       
                        self.menuCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
                        self.menuCollectionView.delegate?.collectionView?(self.menuCollectionView, didSelectItemAt:  IndexPath(item: 0, section: 0))
                    }
                }
            }
        } catch {
            print(error)
        }
    }
     
}


extension DashboardViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryCount = menus.category?.count
        if categoryCount == 0{
            self.menuCollectionView.setEmptyMessage("No data found..")
            return 0
        }else{
            self.menuCollectionView.restore()
            return categoryCount!
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        let categories = menus.category![indexPath.row]
        if let categoryName = categories.categoryName{
            cell.menuNameLbl.text = categoryName
        }
       
        if let categoryImage = categories.categoryImage{
            cell.menuImageView.image = UIImage(named: categoryImage)
        }

        if indexPath.item == selectedItem{
            cell.mainView.backgroundColor = #colorLiteral(red: 0.9860013127, green: 0.4296327233, blue: 0.2332445383, alpha: 1)
            cell.menuImageMainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.menuNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else{
            cell.mainView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell.menuImageMainView.backgroundColor = #colorLiteral(red: 0.9214683175, green: 0.9216262698, blue: 0.9214583635, alpha: 1)
            cell.menuNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedItem = indexPath.item
        self.menuCollectionView.reloadData()
        let categories = menus.category![indexPath.row]
        if let subCategories = categories.subCategory{
            self.subCategories = subCategories
            DispatchQueue.main.async {
                self.subMenuTableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 82
        let height = 130
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
}

extension DashboardViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryCount = subCategories.count
        if categoryCount == 0{
            self.subMenuTableView.setEmptyMessage("No data found..")
            return 0
        }else{
            self.subMenuTableView.restore()
            return categoryCount
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuTableViewCell", for: indexPath) as! SubMenuTableViewCell
        let subCategory = subCategories[indexPath.row]
        
        if let itemName = subCategory.title{
            cell.itemNameLbl.text = itemName
        }
        if let itemImage = subCategory.image{
            cell.itemImageView.image = UIImage(named: itemImage)
        }
        if let itemReadyTime = subCategory.readyTime{
            cell.timeLbl.text = itemReadyTime
        }
        if let itemRating = subCategory.rating{
            cell.itemRatingLbl.text = String(itemRating)
        }
        if let itemDescription = subCategory.description{
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "\(itemDescription) - $", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
            text.append(NSAttributedString(string: "$$", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
            cell.itemDescriptionLbl.attributedText = text
        }
        
        DispatchQueue.main.async {
            self.tableViewHeightConstraint.constant = self.subMenuTableView.contentSize.height
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        let subCategory = subCategories[indexPath.row]
        if let itemTitle = subCategory.title{
            vc.titleName = itemTitle
        }
      
        if let items = subCategory.items{
            if subCategory.items?.count != 0{
                vc.items = items[0]
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.showAlert(title: "", message: "No data found..", theme: .warning)
            }
           
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


