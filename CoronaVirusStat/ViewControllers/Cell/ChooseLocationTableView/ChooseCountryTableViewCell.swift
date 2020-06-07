//
//  ChooseCountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 15.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class ChooseCountryTableViewCell: UITableViewCell {

    static let reuseID = "ChooseCountryCell"
    
    @IBOutlet var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
