//
//  DetailsTableViewCell.swift
//  astronauts
//
//  Created by akash on 14/03/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var craft: UILabel!
    @IBOutlet weak var customBackgroud: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customBackgroud.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(name: String, craftname: String) {
        nameLabel.text = name
        craft.text = craftname
    }
}
