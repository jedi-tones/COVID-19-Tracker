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
        let taskGroup = DispatchGroup()
        
        queue.async(group: taskGroup) {
            
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
            
            //calculate difference for 1 day for brief
            guard let countTimeSeriesBrief = realm.objects(BriefRealm.self).first?.timesSeries.count else { return }
            guard let death = realm.objects(BriefRealm.self).first?.death else { return }
            guard let confirmed = realm.objects(BriefRealm.self).first?.confirmed else { return }
            guard let recovered = realm.objects(BriefRealm.self).first?.recovered else { return }
            guard let lastTimeSeries = realm.objects(BriefRealm.self).first?.timesSeries[countTimeSeriesBrief - 2] else { return }
            
            let difConfirmed = confirmed - lastTimeSeries.confirmed
            let difDeath = death - lastTimeSeries.deaths
            let difRecovered = recovered - lastTimeSeries.recovered
            
            do {
                try realm.write {
                    realm.create(BriefRealm.self,
                                 value: ["id": 1,
                                         "differenceConfirmed": difConfirmed,
                                         "differenceDeath": difDeath,
                                         "differenceRecovered": difRecovered],
                                 update: .modified)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        //when taskgroup complite do escaping complition
        taskGroup.notify(queue: .main) {
            complition()
        }
    }
}
