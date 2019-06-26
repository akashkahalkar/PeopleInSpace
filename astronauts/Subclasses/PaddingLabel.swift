//
//  PaddingLabel.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        super.drawText(in: rect.inset(by: insets))
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}
