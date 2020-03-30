//
//  Statistic.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 30.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


class Statistic {
    
    static func getAddNewStats(currentCountry: VirusRealm, forValuse: DifferenceTimeSeries) -> (date:String, value:Int) {
        let timeSeriesForCountry = currentCountry.timeSeries.sorted(byKeyPath: "date", ascending: true)
        guard let lastValue = timeSeriesForCountry.last else { return ("20/03/28" , 0) }
        if timeSeriesForCountry.count > 1 {
            let differenceConfirmed = currentCountry.confirmed - timeSeriesForCountry[timeSeriesForCountry.count - 2].confirmed
            let differenceDeath = currentCountry.deaths - timeSeriesForCountry[timeSeriesForCountry.count - 2].deaths
            let differenceRecovered = currentCountry.recovered - timeSeriesForCountry[timeSeriesForCountry.count - 2].recovered
            let previosDate = lastValue.date
            
            switch forValuse {
            case .confirmed:
                return (previosDate, differenceConfirmed)
            case .death:
                return (previosDate, differenceDeath)
            default:
                return (previosDate, differenceRecovered)
            }
        } else { return ("20/03/28", 0) }
        
    }
}
