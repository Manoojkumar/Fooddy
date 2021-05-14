//
//  SubMenuTableViewCell.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import UIKit

class SubMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemRatingLbl: UILabel!
    @IBOutlet weak var itemDescriptionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.timeView.roundCorners(corners: [.topRight,.bottomLeft], radius: 12.0)
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
