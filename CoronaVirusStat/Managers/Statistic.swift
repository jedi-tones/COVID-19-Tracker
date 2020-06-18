//
//  Statistic.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 30.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift

class Statistic {
    
    //country statistic for one day
    static func getAddNewStats(complition: @escaping ()-> Void) {
        
        let realm = try! Realm()
        let countries = realm.objects(VirusRealm.self)
        
        for country in countries {
            
            let timeSeriesForCountry = country.timeSeries.sorted(byKeyPath: "date", ascending: true)
            guard let lastValue = timeSeriesForCountry.last else { return }
            
            if timeSeriesForCountry.count > 1 {
                let differenceConfirmed = country.confirmed - timeSeriesForCountry[timeSeriesForCountry.count - 2].confirmed
                let differenceDeath = country.deaths - timeSeriesForCountry[timeSeriesForCountry.count - 2].deaths
                let differenceRecovered = country.recovered - timeSeriesForCountry[timeSeriesForCountry.count - 2].recovered
                let previosDate = lastValue.date
                
                do {
                    try realm.write {
                        realm.create(VirusRealm.self,
                                     value: ["countryregion": country.countryregion,
                                             "differenceConfirmed": differenceConfirmed,
                                             "differenceDeath": differenceDeath,
                                             "differenceRecovered": differenceRecovered,
                                             "lastDifferenceDate": previosDate],
                                     update: .modified)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else { complition(); return }
            
        }
        complition()
    }
    
    static func getPercent(for statistic: TypeOfStatistic, country: VirusRealm) -> Double {
        
        
        switch statistic {
        case .recovered:
            let recovered = Double (country.recovered)
            let confirmed = Double (country.confirmed)
            let percent = ((recovered * 100 / confirmed) * 10).rounded() / 10
            return percent
        case .death:
            let death = Double (country.deaths)
            let confirmed = Double (country.confirmed)
            let percent = ((death * 100 / confirmed) * 10).rounded() / 10
            return percent
        default:
            return 0.0
        }
    }
}

