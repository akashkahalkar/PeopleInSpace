//
//  ColorExtension.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addGradientLayer(colors: [UIColor], cornerRadius: CGFloat = 10, startPoint: GradientPoints = .top, endPoint: GradientPoints = .bottom) {
        let gLayer = CAGradientLayer()
        gLayer.frame = bounds
        gLayer.cornerRadius = cornerRadius
        gLayer.startPoint = startPoint.point
        gLayer.endPoint = endPoint.point
        gLayer.colors = colors.map{ $0.cgColor }
        self.layer.insertSublayer(gLayer, at: 0)
    }
    
    func addShadow() {
        layer.shadowPath =
            UIBezierPath(roundedRect: bounds,
                         cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
}

extension UIButton {
    func getFancyButton() {
        let btnColors = FlatColors.NeonLife.colors()
        self.addGradientLayer(colors: [btnColors[0], btnColors[1]], cornerRadius: 10.0)
        self.setTitleColor(.black, for: .normal)
        self.addShadow()
    }
}

