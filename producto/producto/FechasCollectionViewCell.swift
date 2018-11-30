//
//  FechasCollectionViewCell.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class FechasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circulo: UIView!
    @IBOutlet weak var fechalabel: UILabel!
    func dibujacirculo() {
        let centrocirculo = circulo.center
        let circuloPath = UIBezierPath(arcCenter: centrocirculo, radius: (circulo.bounds.width/2 - 5), startAngle: -CGFloat.pi/2, endAngle: (2 * CGFloat.pi), clockwise: true)
        let circuloLayer = CAShapeLayer()
        circuloLayer.path = circuloPath.cgPath
        circuloLayer.strokeColor = UIColor.red.cgColor
        circuloLayer.lineWidth = 2
        circuloLayer.strokeEnd = 0
        circuloLayer.fillColor = UIColor.clear.cgColor
        circuloLayer.lineCap = CAShapeLayerLineCap.round
        let animacion = CABasicAnimation(keyPath: "strokeEnd")
        animacion.duration = 10
        animacion.toValue = 1
        animacion.isRemovedOnCompletion = false
        circuloLayer.add(animacion, forKey: nil)
        circulo.layer.addSublayer(circuloLayer)
        circulo.layer.backgroundColor = UIColor.clear.cgColor
    }
}
