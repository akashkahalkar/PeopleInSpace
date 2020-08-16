//
//  HomeCollectionViewCell.swift
//  astronauts
//
//  Created by Akash kahalkar on 21/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundViewForSubtitle: UIView!
    
    let cornerRadius: CGFloat = 10
    var tapEvent: ((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func colorTheCell() {
        backgroundColor = .clear
    
        bgView.addShadow()
        bgView.layer.cornerRadius = cornerRadius
        //bgView.addGradientLayer(colors: [colors[1], colors[0]])
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true

        let btnColors = getButtonColors()
        buttonOutlet.addGradientLayer(colors: [btnColors[0], btnColors[1]], cornerRadius: cornerRadius)
        buttonOutlet.setTitleColor(.black, for: .normal)
        buttonOutlet.addShadow()
        backgroundViewForSubtitle.layer.cornerRadius = cornerRadius
//        let blurrView = UIVisualEffectView(effect: getBlurrEffect())
//        blurrView.layer.cornerRadius = cornerRadius
//        blurrView.clipsToBounds = true
//        blurrView.alpha = 0.4
//        backgroundViewForSubtitle.addSubview(blurrView)
//
//        blurrView.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = NSLayoutConstraint(item: blurrView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundViewForSubtitle, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: blurrView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundViewForSubtitle, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//        let widthConstraint = NSLayoutConstraint(item: blurrView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundViewForSubtitle, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
//        let heightConstraint = NSLayoutConstraint(item: blurrView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundViewForSubtitle, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
//        backgroundViewForSubtitle.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
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
    
    func setupCell(cellType: CollectionsCellType, buttonTitle: String, tag: Int, peopleCount: Int = 0) {
        self.tag = tag
        buttonOutlet.setTitle(buttonTitle, for: .normal)
        imageView.image = cellType.image()
        titleLabel.text = cellType.title()
        
        if cellType == .peopleCell {
            subtitleLabel.text = cellType.subtitle().replacingOccurrences(of: "##COUNT##", with: String(peopleCount))
        } else {
            subtitleLabel.text = cellType.subtitle()
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        tapEvent?(tag)
    }
}

