//
//  ImageOfTheDayViewController.swift
//  astronauts
//
//  Created by akash on 16/08/20.
//  Copyright © 2020 akash. All rights reserved.
//

import UIKit

class ImageOfTheDayViewController: UIViewController {

    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageDescription: UITextView!
    @IBOutlet weak var imageOfTheDay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImageOfTheDay()
        
        //let gView = UIView(frame: view.frame)
        let gradientLayer = CAGradientLayer()
        let colors = FlatColors.Sunrise.colors()
        gradientLayer.colors = [colors[3].cgColor, colors[0].cgColor]
        gradientLayer.frame = view.frame
        //view.layer.addSublayer(gradientLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        imageOfTheDay.layer.cornerRadius = 10
        imageOfTheDay.clipsToBounds = true
        imageDescription.layer.cornerRadius = 10
        imageDescription.clipsToBounds = true
    }
    
    private func getImageOfTheDay() {
        RequestManager.shared.getImageOfTheDay { (NOPD) in
            
            DispatchQueue.main.async {
                
                switch NOPD.result.status {
                    
                case .success:
                    self.imageTitle.text = NOPD.title
                    self.imageDescription.text = NOPD.explanation
                    if let image = RequestManager.shared.imageCache[NOPD.imageURL] {
                        self.imageOfTheDay.image = image
                    } else if let url = URL(string: NOPD.imageURL) {
                        
                        DispatchQueue.global().async {
                            do {
                                let data = try? Data(contentsOf: url)
                                DispatchQueue.main.async {
                                    if let data = data {
                                        self.imageOfTheDay.image = UIImage(data: data)
                                        RequestManager.shared.imageCache[NOPD.imageURL] = self.imageOfTheDay.image
                                    }
                                }
                            }
                        }
                    }
                    
                case .fail:
                    self.imageTitle.text = NOPD.result.message
                    self.imageDescription.text = ""
                }
            }
        }
    }
}
