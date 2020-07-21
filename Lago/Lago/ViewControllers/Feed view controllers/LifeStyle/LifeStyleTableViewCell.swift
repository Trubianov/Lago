//
//  LifeStyleTableViewCell.swift
//  Lago
//
//  Created by Anton on 7/21/20.
//  Copyright © 2020 LUX. All rights reserved.
//

import UIKit
import Kingfisher

class LifeStyleTableViewCell: UITableViewCell {
    static let reuseID = "LifeStyleTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(lifstyleItem: LifeStyle) {
        self.titleLabel.text = lifstyleItem.title
    }
}
