//
//  UIVIew+Styles.swift
//  Fooddy
//
//  Created by Mano on 14/05/21.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    

    @IBInspectable var circleView:Bool {
            get {
                return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
            }
            set {
                if newValue {
                    layer.cornerRadius = min(self.frame.width, self.frame.height) / CGFloat(2.0)
                    layer.masksToBounds = true
                }
                else{
                    layer.cornerRadius = 0.0
                    layer.masksToBounds = false
                }
            }
        }
    
    @IBInspectable
       var shadowRadius: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {

               layer.shadowRadius = newValue
           }
       }
       @IBInspectable
       var shadowOffset : CGSize{

           get{
               return layer.shadowOffset
           }set{

               layer.shadowOffset = newValue
           }
       }

       @IBInspectable
       var shadowColor : UIColor{
           get{
               return UIColor.init(cgColor: layer.shadowColor!)
           }
           set {
               layer.shadowColor = newValue.cgColor
           }
       }
       @IBInspectable
       var shadowOpacity : Float {

           get{
               return layer.shadowOpacity
           }
           set {

               layer.shadowOpacity = newValue

           }
       }

}
