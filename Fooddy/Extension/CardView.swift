//
//  CardView.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    override func layoutSubviews() {
        layer.cornerRadius = 12
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0);
        layer.shadowOpacity = 0.7
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 6.0
    }

}
