//
//  BriefTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 09.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class BriefTableViewCell: UITableViewCell {
    
    @IBOutlet var about: UILabel!
    @IBOutlet var confirmed: UILabel!
    @IBOutlet var death: UILabel!
    @IBOutlet var recovered: UILabel!
    @IBOutlet var difConfirmedLabel: UILabel!
    @IBOutlet var difDeathLabel: UILabel!
    @IBOutlet var difRecoveredLabel: UILabel!
    
    let realm = try! Realm()
    static let reuseID = "BriefCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCell(typeOfData: TypeOfChartData, realmData: VirusRealm?){
        
        var confirmedData = 0
        var deathData = 0
        var recoveredData = 0
        var difConfirmed = 0
        var difDeath = 0
        var difRecovered = 0
        
        switch typeOfData {
        case TypeOfChartData.brief:
            confirmedData = realm.objects(BriefRealm.self).first?.confirmed ?? 0
            deathData = realm.objects(BriefRealm.self).first?.death ?? 0
            recoveredData = realm.objects(BriefRealm.self).first?.recovered ?? 0
            
            difConfirmed = realm.objects(BriefRealm.self).first?.differenceConfirmed ?? 0
            difDeath = realm.objects(BriefRealm.self).first?.differenceDeath ?? 0
            difRecovered = realm.objects(BriefRealm.self).first?.differenceRecovered ?? 0
            
        case TypeOfChartData.country:
            confirmedData = realmData?.confirmed ?? 0
            deathData = realmData?.deaths ?? 0
            recoveredData = realmData?.recovered ?? 0
            about.text = realmData?.countryregion.uppercased()
            
            difConfirmed = realmData?.differenceConfirmed ?? 0
            difDeath = realmData?.differenceDeath ?? 0
            difRecovered = realmData?.differenceRecovered ?? 0
        default:
            confirmedData = realmData?.confirmed ?? 0
            deathData = realmData?.deaths ?? 0
            recoveredData = realmData?.recovered ?? 0
            
            difConfirmed = realmData?.differenceConfirmed ?? 0
            difDeath = realmData?.differenceDeath ?? 0
            difRecovered = realmData?.differenceRecovered ?? 0
        }
        
        
        confirmed.text = confirmedData.formattedWithSeparator
        death.text = deathData.formattedWithSeparator
        recovered.text = recoveredData.formattedWithSeparator
        
        difConfirmedLabel.text = (difConfirmed > 0 ?  "+" : "" ) + (difConfirmed.formattedWithSeparator)
        difDeathLabel.text = (difDeath > 0 ?  "+" : "" ) + (difDeath.formattedWithSeparator)
        difRecoveredLabel.text = (difRecovered > 0 ?  "+" : "" ) + (difRecovered.formattedWithSeparator)
    }
    
    func setLoadTimeSeries(){
        difConfirmedLabel.text = "calculation"
        difDeathLabel.text = "calculation"
        difRecoveredLabel.text = "calculation"
    }
}


