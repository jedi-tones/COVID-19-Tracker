//
//  FirstCountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 31.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class FirstCountryTableViewCell: UITableViewCell {

    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var percentMortalityLabel: UILabel!
    @IBOutlet var difConfirmed: UILabel!
    @IBOutlet var difDeath: UILabel!
    @IBOutlet var difRecovered: UILabel!
    
    static let reuseID = "firstCountryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   func setCell(data: BriefRealm) {
        
        confirmedLabel.text = "\(data.confirmed)"
        deathLabel.text = "\(data.death)"
        recoveredLabel.text = "\(data.recovered)"
       
        difConfirmed.text = ""
        difDeath.text = ""
        difRecovered.text = ""
        
    }
    
    func setLoadTimeSeries(){
        difConfirmed.text = "calculation"
        difDeath.text = "calculation"
        difRecovered.text = "calculation"
    }
    
}
