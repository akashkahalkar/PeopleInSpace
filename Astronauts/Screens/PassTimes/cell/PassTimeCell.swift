//
//  PassTimeCell.swift
//  astronauts
//
//  Created by Akash kahalkar on 26/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class PassTimeCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    var data: ISSPassTime!
    let day = FlatColors.Maldives.colors()
    let night = FlatColors.SolidStone.colors()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let componentString = data.date.getShortTime().components(separatedBy: " ").last!
        if componentString == "AM" {
            bgView.addGradientLayer(colors: [day[2], day[3]], cornerRadius: 5, startPoint: .bottomLeft, endPoint: .topRight)
        } else {
            bgView.addGradientLayer(colors: [night[2], night[3]], cornerRadius: 5, startPoint: .bottomLeft, endPoint: .topRight)
        }
        bgView.addShadow()
    }

    func setupCell(data: ISSPassTime) {
        self.data = data
        dateLabel.text = data.date.getDate()
        timeLabel.text = data.date.getShortTime()
        durationLabel.text = "ISS will visible for \(Int(data.time.minute)) minutes"
        
        
    }
}
