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
    
    let titleArray = ["People in Space",
                      "Current Location Of the ISS",
                      "Next Pass Above You"]
    
    let subtitleArray = ["There are total of ##COUNT## people in space.",
                         """
            The International Space Station (ISS) is a space station, its first component was launched into orbit in 1998.\n
            Orbital speed: 27,600 km/h\n
            Orbital period: 92.68 minutes\n
            Orbital inclination: 51.64 degrees\n
            Orbits per day: 15.54\n
            Tap the button below to see current location of space station.
            """,
            "Check when the ISS will move from above you."]
    
    var peopleCount = 0
    let cornerRadius: CGFloat = 10
    var tapEvent: ((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func colorTheCell() {
        backgroundColor = .clear
        //let colors = FlatColors.NeonLife.colors()
        
        bgView.addShadow()
        bgView.layer.cornerRadius = cornerRadius
        //bgView.addGradientLayer(colors: [colors[1], colors[0]])
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true

        let btnColors = FlatColors.NeonLife.colors()
        buttonOutlet.addGradientLayer(colors: [btnColors[0], btnColors[1]], cornerRadius: cornerRadius)
        buttonOutlet.setTitleColor(.black, for: .normal)
        buttonOutlet.addShadow()
        
        backgroundViewForSubtitle.layer.cornerRadius = cornerRadius
        //subtitleLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
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
        titleLabel.text = titleArray[tag]
        if tag == 0 {
            subtitleLabel.text = subtitleArray[tag].replacingOccurrences(of: "##COUNT##", with: String(peopleCount))
        } else {
            subtitleLabel.text = subtitleArray[tag]
        }
    }
}

