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
    var tapEvent: ((Int)->())?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var peopleCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        let colors = FlatColors.NeonLife.colors()
        
        bgView.addShadow()
        bgView.layer.cornerRadius = 10
        bgView.addGradientLayer(colors: [colors[1], colors[0]])
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        let btnColors = FlatColors.NeonLife.colors()
        buttonOutlet.addGradientLayer(colors: [btnColors[0], btnColors[1]], cornerRadius: 10.0)
        buttonOutlet.setTitleColor(.black, for: .normal)
        buttonOutlet.addShadow()
        
        subtitleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//        subtitleLabel.safeAreaInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setupCell(buttonTitle: String, tag: Int, image: UIImage, peopleCount: Int = 0) {
        self.peopleCount = peopleCount
        buttonOutlet.setTitle(buttonTitle, for: .normal)
        self.tag = tag
        imageView.image = image
        getMessage(for: tag)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        tapEvent?(tag)
    }
    
    func getMessage(for tag: Int) {
        if tag == 0 {
            titleLabel.text = "People in Space"
            subtitleLabel.text = "There are total of \(peopleCount) people in space."
        } else if tag == 1 {
            titleLabel.text = "Current Location Of ISS"
            subtitleLabel.text = """
            The International Space Station (ISS) is a space station, Its first component was launched into orbit in 1998.\n
            Orbital speed: 27,600 km/h\n
            Orbital period: 92.68 minutes\n
            Orbital inclination: 51.64 degrees\n
            Orbits per day: 15.54\n
            check to see current location of space station.
            """
        } else {
            titleLabel.text = "Next Pass Above You"
            subtitleLabel.text = "Check when the ISS will move from above you."
        }
    }
}

