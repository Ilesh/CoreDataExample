//
//  IPView.swift
//  EZPickup_Rider

//

import UIKit

class IPView: UIView {
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            if self.tag == 301 {
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
                shadowLayer.fillColor = (self.backgroundColor ?? UIColor.white).cgColor
                shadowLayer.shadowColor = UIColor.darkGray.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                shadowLayer.shadowOpacity = 0.4
                shadowLayer.shadowRadius = 2
            }
            else if self.tag == 302 {
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
                shadowLayer.fillColor = (self.backgroundColor ?? UIColor.white).cgColor
                shadowLayer.shadowColor = UIColor.darkGray.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                shadowLayer.shadowOpacity = 0.4
                shadowLayer.shadowRadius = 2
            }
            else{
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
                shadowLayer.fillColor = (self.backgroundColor ?? UIColor.white).cgColor
                shadowLayer.shadowColor = UIColor.darkGray.cgColor
                shadowLayer.shadowPath = shadowLayer.path
                shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                shadowLayer.shadowOpacity = 0.8
                shadowLayer.shadowRadius = 8
            }
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}


