//
//  HomeCollectionViewCell.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet private weak var buttonOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundViewForSubtitle: UIView!
    
    let cornerRadius: CGFloat = 10
    var tapEvent: ((Int)->())?
    
    override func awakeFromNib() {
        self.buttonOutlet.isHidden = true
        super.awakeFromNib()
    }
    
    func colorTheCell() {
        backgroundColor = .clear
        bgView.addShadow()
        bgView.layer.cornerRadius = cornerRadius
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true
        
        backgroundViewForSubtitle.layer.cornerRadius = cornerRadius

        let btnColors = getButtonColors()
        buttonOutlet.addGradientLayer(colors: [btnColors[0], btnColors[1]], cornerRadius: cornerRadius)
        buttonOutlet.setTitleColor(.black, for: .normal)
        buttonOutlet.addShadow()
    }
    
    private func getBlurrEffect() -> UIBlurEffect {
        if #available(iOS 13.0, *) {
            return UIBlurEffect(style: .dark)
        } else {
            return UIBlurEffect(style: .light)
        }
    }
    
    private func getButtonColors() -> [UIColor] {
        
        switch tag {
        case 0:
            return FlatColors.NeonLife.colors().reversed()
        case 1:
            return FlatColors.Sunrise.colors()
        default:
            return FlatColors.Kyoopal.colors()
        }
    }
    
    func setupCell(cellType: CollectionsCellType, buttonTitle: String, tag: Int, peopleCount: Int) {
        self.tag = tag
        imageView.image = cellType.image()
        titleLabel.text = cellType.title()
        
        switch cellType {
            
        case .peopleCell:
            configurePeoplesCell(peopleCount: peopleCount, cellType: cellType)
        case .passTime:
            self.buttonOutlet.isHidden = true
            subtitleLabel.text = cellType.subtitle()
        case .currentLocation, .imageOfTheDay:
            subtitleLabel.text = cellType.subtitle()
            self.buttonOutlet.isHidden = false
        }
        buttonOutlet.setTitle(buttonTitle, for: .normal)
    }
    
    private func configurePeoplesCell(peopleCount: Int, cellType: CollectionsCellType) {
        if peopleCount > 0 {
            self.buttonOutlet.isHidden = false
            self.subtitleLabel.text = cellType.subtitle()
                .replacingOccurrences(of: "##COUNT##",
                                      with: String(peopleCount))
            
        } else {
            subtitleLabel.text = "No Information available"
            subtitleLabel.textAlignment = .center
            buttonOutlet.isHidden = true
        }
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        tapEvent?(tag)
    }
}

