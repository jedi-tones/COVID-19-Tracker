//
//  CountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class CountryTableViewCell: UITableViewCell {
    
    static let reuseID = "CountryCell"
    
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var lastUpdate: UILabel!
    @IBOutlet var difConfirmed: UILabel!
    @IBOutlet var difDeath: UILabel!
    @IBOutlet var difRecovered: UILabel!
    
    
     func setCell(data: VirusRealm) {
        
        countryLabel.text = data.countryregion
        confirmedLabel.text = "\(data.confirmed)"
        deathLabel.text = "\(data.deaths)"
        recoveredLabel.text = "\(data.recovered)"
        lastUpdate.text = "\(data.lastupdate)"
        
        difConfirmed.text = "+\( Statistic.getAddNewStats(currentCountry: data, forValue: .confirmed).value)"
        difDeath.text = "+\(Statistic.getAddNewStats(currentCountry: data, forValue: .death).value)"
        difRecovered.text = "+\( Statistic.getAddNewStats(currentCountry: data, forValue: .recovered).value)"
        
     //    accessoryType = .disclosureIndicator
    }
    
    func setLoadTimeSeries(){
        difConfirmed.text = "calculation"
        difDeath.text = "calculation"
        difRecovered.text = "calculation"
    }
    
}
