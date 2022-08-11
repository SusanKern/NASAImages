//
//  UIView+SAK.swift
//  NASA
//
//  Created by Susan Kern on 8/11/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import UIKit

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
}
