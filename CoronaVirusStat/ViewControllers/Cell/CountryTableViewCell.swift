//
//  CountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static let reuseID = "CountryCell"
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var lastUpdate: UILabel!
    
    
     func setCell(data: VirusRealm) {
        
        countryLabel.text = data.countryregion
        confirmedLabel.text = "\(data.confirmed)"
        deathLabel.text = "\(data.deaths)"
        recoveredLabel.text = "\(data.recovered)"
        lastUpdate.text = "\(data.lastupdate)"
    }
    
}
