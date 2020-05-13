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
        confirmedLabel.text = data.confirmed.formattedWithSeparator
        deathLabel.text = data.deaths.formattedWithSeparator
        recoveredLabel.text = data.recovered.formattedWithSeparator
        
        
        lastUpdate.text = ConvertDate.convertToMMMdHMMa(oldDate: data.lastupdate)
        
        let difConfirmedData = Statistic.getAddNewStats(currentCountry: data, forValue: .confirmed).value
        let difDeathData = Statistic.getAddNewStats(currentCountry: data, forValue: .death).value
        let difRecoveredData = Statistic.getAddNewStats(currentCountry: data, forValue: .recovered).value
        
        difConfirmed.text = (difConfirmedData > 0 ?  "+" : "" ) + (difConfirmedData.formattedWithSeparator)
        difDeath.text = (difDeathData > 0 ?  "+" : "" ) + (difDeathData.formattedWithSeparator)
        difRecovered.text = (difRecoveredData > 0 ?  "+" : "" ) + (difRecoveredData.formattedWithSeparator)
        
     //    accessoryType = .disclosureIndicator
    }
    
    func setLoadTimeSeries(){
        difConfirmed.text = "calculation"
        difDeath.text = "calculation"
        difRecovered.text = "calculation"
    }
    
}
