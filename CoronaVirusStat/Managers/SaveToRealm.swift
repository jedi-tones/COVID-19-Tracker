//
//  SaveToRealm.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift

class SaveToRealm {
    
    static let shared = SaveToRealm()
    
    let realm = try! Realm()
    
    //MARK: - saveLatestOnlyCountry
    func saveLatestOnlyCountry(data: [CoronaVirusStateOnlyCountry], complition: @escaping () -> Void ) {
        
        for currentCountry in data {
            if let country = currentCountry.countryregion {
                let newCountryName = country.replacingOccurrences(of: "\'", with: "")
                let existCountry = realm.objects(VirusRealm.self).filter("countryregion = '\(newCountryName)'")
                
                if existCountry.isEmpty {
                    addLatestOnlyCountry(newData: currentCountry)
                } else {
                    if let currentVirusRealm = existCountry.first {
                        changeLatestValueOnlyCountry(newData: currentCountry, element: currentVirusRealm)
                    }
                }
            }
        }
        complition()
    }
    //MARK: - saveLatestCity
    func saveLatestCity(data: [CoronaVirusStateLatest]) {
        
        for currentCountry in data {
            if let country = currentCountry.countryregion {
                let newCountryName = country.replacingOccurrences(of: "\'", with: "")
                let existCountry = realm.objects(VirusRealm.self).filter("countryregion = '\(newCountryName)'")
                
                if !existCountry.isEmpty {
                    if let currentVirusRealm = existCountry.first {
                        addLatestCityData(element: currentVirusRealm, newData: currentCountry)
                    }
                }
            }
        }
    }
    //MARK: - saveTimeSeriesOnlyCountry
    func saveTimeSeriesOnlyCountry(data: [CoronaVirusStateTimeSeries], complition: @escaping () -> Void){
        
        for currentCountry in data {
            if let country = currentCountry.countryregion {
                let newCountryName = country.replacingOccurrences(of: "\'", with: "")
                let existCountries = realm.objects(VirusRealm.self).filter("countryregion = '\(newCountryName)'")
                
                if !existCountries.isEmpty {
                    if let exitCountry = existCountries.first {
                        addTimeSeriesOnlyCountry(element: exitCountry, newData: currentCountry)
                    }
                }
            }
        }
        complition()
    }
    //MARK: - saveTimeSeriesCity
    func saveTimeSeriesCity(data: [CoronaVirusCityTimesSeries]) {
        for city in data {
            if let currentCityName = city.provincestate {
                let newCityName = currentCityName.replacingOccurrences(of: "\'", with: "")
                let existCities = realm.objects(ProvincestateRealm.self).filter("province = '\(newCityName)'")
                
                if !existCities.isEmpty {
                    if let existCity = existCities.first {
                        addTimeSeriesCity(element: existCity, newData: city)
                    }
                }
            }
        }
    }
    
    //MARK: - addBrief
    func addBrief(newData: Brief, complition: @escaping () -> Void){
        
        DispatchQueue.main.async {
            let brief = self.realm.objects(BreafRealm.self)
            do {
                try self.realm.write{
                    if brief.isEmpty {
                        self.realm.add(self.virusRealmBrief(newData: newData))
                    } else {
                        let _ = self.virusRealmBrief(newData: newData)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        complition()
    }
    
    //MARK: - getTimeSeriesBrief
    func getTimeSeriesBrief(complition: @escaping () -> Void) {
        do {
            try self.realm.write{
                virusRealmTimeSeriesBrief()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        complition()
    }
    


    //MARK: - private func
    
    
    
    //MARK: - addLatestOnlyCountry
    private func addLatestOnlyCountry(newData: CoronaVirusStateOnlyCountry ) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write{
                    self.realm.add(self.virusRealmElement(element: nil, newData: newData))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    //MARK: - changeLatestValueOnlyCountry
    private func changeLatestValueOnlyCountry(newData: CoronaVirusStateOnlyCountry, element: VirusRealm){
        
        DispatchQueue.main.async {
            do {
                try self.realm.write{
                    self.realm.add(self.virusRealmElement(element: element, newData: newData), update: .modified)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - addlatestCityData
    private func addLatestCityData(element: VirusRealm, newData: CoronaVirusStateLatest) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write{
                    self.virusRealmElementCity(element: element, newData: newData)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
     //MARK: - addTimeSeriesOnlyCountry
    private func addTimeSeriesOnlyCountry(element: VirusRealm, newData: CoronaVirusStateTimeSeries) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write{
                    self.virusRealmTimeSeriesCountry(element: element, newData: newData)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    //MARK: - addTimeSeriesCity
    private func addTimeSeriesCity(element: ProvincestateRealm, newData: CoronaVirusCityTimesSeries) {
        
        DispatchQueue.main.async {
            do {
                try self.realm.write{
                    self.virusRealmTimeSeriesCity(element: element, newData: newData)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
        
    //MARK: - virusRealmBrief
    private func virusRealmBrief(newData: Brief) -> BreafRealm {
        let existBreaf = realm.objects(BreafRealm.self)
        if existBreaf.isEmpty{
            let newBreaf = BreafRealm()
            newBreaf.confirmed = newData.confirmed ?? 0
            newBreaf.death = newData.deaths ?? 0
            newBreaf.recovered = newData.recovered ?? 0
            return newBreaf
        } else {
            let breaf = existBreaf.first!
            breaf.confirmed = newData.confirmed ?? 0
            breaf.death = newData.deaths ?? 0
            breaf.recovered = newData.recovered ?? 0
            return breaf
        }
    }
    
    
    //MARK: - virusRealmElement
    private func virusRealmElement(element: VirusRealm?, newData: CoronaVirusStateOnlyCountry) -> VirusRealm {
        
        let newCountryName = newData.countryregion?.replacingOccurrences(of: "\'", with: "") ?? "Unknow country"
        
        //edit exist country
        if let editElement = element {
            
            editElement.countrycode = newData.countrycode?.iso2 ?? ""
            editElement.lastupdate = newData.lastupdate ?? "2020-03-21T20:42:00.004Z"
            
            //edit exist country location
            if let location = editElement.location.first  {
                location.lat = newData.location.lat ?? 0.0
                location.lng = newData.location.lng ?? 0.0
            } else {
                //create new country location
                let location = LocationRealm()
                location.lat = newData.location.lat ?? 0.0
                location.lng = newData.location.lng ?? 0.0
                editElement.location.append(location)
            }
            
            editElement.confirmed = newData.confirmed ?? 0
            editElement.deaths = newData.deaths ?? 0
            editElement.recovered = newData.recovered ?? 0
            return editElement
            
        } else {
            //create new country
            let newCountry = VirusRealm()
            newCountry.countryregion = newCountryName
            newCountry.countrycode = newData.countrycode?.iso2 ?? ""
            newCountry.lastupdate = newData.lastupdate ?? "2020-03-21T20:42:00.004Z"
            
            let location = LocationRealm()
            location.lat = newData.location.lat ?? 0.0
            location.lng = newData.location.lng ?? 0.0
            
            newCountry.location.append(location)
            newCountry.confirmed = newData.confirmed ?? 0
            newCountry.deaths = newData.deaths ?? 0
            newCountry.recovered = newData.recovered ?? 0
            return newCountry
        }
        
    }
    //MARK: - virusRealmElementCity
    
    private func virusRealmElementCity(element: VirusRealm, newData: CoronaVirusStateLatest) {
        var newCityName = newData.provincestate?.replacingOccurrences(of: "\'", with: "") ?? "Unknow city"
        if newCityName == "" { newCityName = "No details information" }
        let existCity = element.province.filter("province = '\(newCityName)'")
        
        //if  city does not exist
        if existCity.isEmpty {
            let province = ProvincestateRealm()
            let location = LocationRealm()
            
            location.lat = newData.location?.lat ?? 0
            location.lng = newData.location?.lng ?? 0
            
            province.province = newCityName
            province.confirmed = newData.confirmed ?? 0
            province.deaths = newData.deaths ?? 0
            province.recovered = newData.recovered ?? 0
            province.location.append(location)
            element.province.append(province)
            
        } else {
            //city is exist
            if let editCity = existCity.first {
                editCity.confirmed = newData.confirmed ?? 0
                editCity.deaths = newData.deaths ?? 0
                editCity.recovered = newData.recovered ?? 0
            }
        }
    }
    
    //MARK: - virusRealmTimeSeriesCountry
    private func virusRealmTimeSeriesCountry(element: VirusRealm, newData: CoronaVirusStateTimeSeries) {
        
        let dates = newData.timeseries.keys.sorted(by: > )
        for date in dates {
            let convertedDate = ConvertDate.convertToYyMmDd(oldDate: date)
            let existDate = element.timeSeries.filter("date = '\(convertedDate)'")
            
            
            let timeSeries = TimeseryRealm()
            timeSeries.date = convertedDate
            timeSeries.confirmed = newData.timeseries[date]?.confirmed ?? 0
            timeSeries.deaths = newData.timeseries[date]?.deaths ?? 0
            timeSeries.recovered = newData.timeseries[date]?.recovered ?? 0
            
            //if  city does not exist
            if existDate.isEmpty {
                element.timeSeries.append(timeSeries)
            } else {
                if let currentDate = existDate.first {
                    currentDate.date = convertedDate
                    currentDate.confirmed = newData.timeseries[date]?.confirmed ?? 0
                    currentDate.deaths = newData.timeseries[date]?.deaths ?? 0
                    currentDate.recovered = newData.timeseries[date]?.recovered ?? 0
                }
            }
        }
    }
    //MARK: - virusRealmTimeSeriesCity
    private func virusRealmTimeSeriesCity(element: ProvincestateRealm, newData: CoronaVirusCityTimesSeries) {
        let dates = newData.timeseries.keys.sorted(by: >)
        for date in dates {
            let existDate = element.timesSeries.filter("date = '\(date)'")
            
            let timeSeries = TimeseryRealm()
            timeSeries.date = date
            timeSeries.confirmed = newData.timeseries[date]?.confirmed ?? 0
            timeSeries.deaths = newData.timeseries[date]?.deaths ?? 0
            timeSeries.recovered = newData.timeseries[date]?.recovered ?? 0
            
            if existDate.isEmpty {
                element.timesSeries.append(timeSeries)
            } else {
                if let currentDate = existDate.first {
                    currentDate.date = date
                    currentDate.confirmed = newData.timeseries[date]?.confirmed ?? 0
                    currentDate.deaths = newData.timeseries[date]?.confirmed ?? 0
                    currentDate.recovered = newData.timeseries[date]?.confirmed ?? 0
                }
            }
        }
    }
    
    
    private func virusRealmTimeSeriesBrief() {
        
        let data = realm.objects(VirusRealm.self).sorted(byKeyPath: "countryregion", ascending: false)
        let breaf = realm.objects(BreafRealm.self)
        
        guard let timeSeriesCount = data.first?.timeSeries.count else { return }
        
        for numberDate in 0..<timeSeriesCount {
            print(#function)
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
            
            breaf.first?.timesSeries.append(breafTimeSeries)
        }
    }
}


