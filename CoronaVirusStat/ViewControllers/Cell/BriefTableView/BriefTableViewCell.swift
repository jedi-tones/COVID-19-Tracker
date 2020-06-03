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
    
    let realm = try! Realm()
    static let reuseID = "BriefCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCell(typeOfData: TypeOfChartData, realmData: VirusRealm?){
        
        var confirmedData = 0
        var deathData = 0
        var recoveredData = 0
        
        switch typeOfData {
        case TypeOfChartData.brief:
            confirmedData = realm.objects(BriefRealm.self).first?.confirmed ?? 0
            deathData = realm.objects(BriefRealm.self).first?.death ?? 0
            recoveredData = realm.objects(BriefRealm.self).first?.recovered ?? 0
        case TypeOfChartData.country:
            confirmedData = realmData?.confirmed ?? 0
            deathData = realmData?.deaths ?? 0
            recoveredData = realmData?.recovered ?? 0
            about.text = realmData?.countryregion.uppercased()
        default:
            confirmedData = realmData?.confirmed ?? 0
            deathData = realmData?.deaths ?? 0
            recoveredData = realmData?.recovered ?? 0
        }

        
        confirmed.text = confirmedData.formattedWithSeparator
        death.text = deathData.formattedWithSeparator
        recovered.text = recoveredData.formattedWithSeparator
        
    }
}


