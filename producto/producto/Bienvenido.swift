//
//  Bienvenido.swift
//  producto
//
//  Created by macbook on 28/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import Foundation
import UIKit

class bienvenido: UIButton {
    
    override func awakeFromNib() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.8
        flash.fromValue = 1.0
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
        layer.borderColor = UIColor.lightText.cgColor
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.white.cgColor
    }
}
