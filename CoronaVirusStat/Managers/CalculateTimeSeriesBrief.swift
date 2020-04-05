//
//  CalculateTimeSeriesBrief.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 02.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift

class CalculateTimeSeriesBrief {
    
    
   static func getTimeSeriesBrief(complition: @escaping () -> Void) {
        
     let queue = DispatchQueue.global(qos: .default)
        
        queue.async {
            
            let realm = try! Realm()
            let data = realm.objects(VirusRealm.self).sorted(byKeyPath: "countryregion", ascending: false)
            let breaf = realm.objects(BriefRealm.self)
            
            guard let timeSeriesCount = data.first?.timeSeries.count else { return }
            
            let breafTimeSeriesCount = breaf.first?.timesSeries.count ?? 0
            
            for numberDate in breafTimeSeriesCount..<timeSeriesCount {
                
                
                let breafTimeSeries = TimeseryRealm()
                guard let lastDate = data.first?.timeSeries.sorted(byKeyPath: "date", ascending: true)[numberDate].date else { return }
                
                breafTimeSeries.confirmed = 0
                breafTimeSeries.deaths = 0
                breafTimeSeries.recovered = 0
                breafTimeSeries.date = lastDate
                
                
                for country in data {
                    let timeSeriesForCountry = country.timeSeries.filter("date = '\(lastDate)'")
                    
                    breafTimeSeries.confirmed += timeSeriesForCountry.first?.confirmed ?? 0
                    breafTimeSeries.deaths += timeSeriesForCountry.first?.deaths ?? 0
                    breafTimeSeries.recovered += timeSeriesForCountry.first?.recovered ?? 0
                    
                }
                
                do {
                    try realm.write{
                        breaf.first?.timesSeries.append(breafTimeSeries)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        complition()
    }
}
