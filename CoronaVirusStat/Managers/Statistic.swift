//
//  Statistic.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 30.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


class Statistic {
    
    static func getAddNewStats(currentCountry: VirusRealm, forValuse: DifferenceTimeSeries) -> Int {
        let timeSeriesForCountry = currentCountry.timeSeries.sorted(byKeyPath: "date", ascending: true)
        guard let lastValue = timeSeriesForCountry.last else { return 0 }
        if timeSeriesForCountry.count > 1 {
            let differenceConfirmed = lastValue.confirmed - timeSeriesForCountry[timeSeriesForCountry.count - 2].confirmed
            let differenceDeath = lastValue.deaths - timeSeriesForCountry[timeSeriesForCountry.count - 2].deaths
            let differenceRecovered = lastValue.recovered - timeSeriesForCountry[timeSeriesForCountry.count - 2].recovered
            
            switch forValuse {
            case .confirmed:
                return differenceConfirmed
            case .death:
                return differenceDeath
            default:
                return differenceRecovered
            }
        } else { return 0 }
        
    }
}
