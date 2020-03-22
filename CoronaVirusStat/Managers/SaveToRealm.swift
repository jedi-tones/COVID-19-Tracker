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
    func saveLatestOnlyCountry(data: [CoronaVirusStateOnlyCountry] ) {
        
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
    }
    //MARK: - saveLatestOnlyCountry
    func saveLatestCity(data: [CoronaVirusStateLatest]) {
        
        for currentCountry in data {
            if let country = currentCountry.countryregion {
                let newCountryName = country.replacingOccurrences(of: "\'", with: "")
                let existCountry = realm.objects(VirusRealm.self).filter("countryregion = '\(newCountryName)'")
                
                if existCountry.isEmpty {
                    
                } else {
                    if let currentVirusRealm = existCountry.first {
                        addlatestCityData(element: currentVirusRealm, newData: currentCountry)
                    }
                }
            }
        }
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
    private func addlatestCityData(element: VirusRealm, newData: CoronaVirusStateLatest) {
        
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
    
    //MARK: - virusRealmElement
    private func virusRealmElement(element: VirusRealm?, newData: CoronaVirusStateOnlyCountry) -> VirusRealm {
        
        let newCountryName = newData.countryregion?.replacingOccurrences(of: "\'", with: "") ?? "Unknow country"
        
        //edit exist country
        if let editElement = element {
            
            editElement.countrycode = newData.countrycode?.iso2 ?? ""
            editElement.lastupdate = newData.lastupdate ?? "2020-03-21T20:42:00.004Z"
            
            if let location = editElement.location.first  {
                location.lat = newData.location.lat ?? 0.0
                location.lng = newData.location.lng ?? 0.0
            } else {
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
        let newCityName = newData.provincestate?.replacingOccurrences(of: "\'", with: "") ?? "Unknow city"
        let existCity = element.province.filter("province = '\(newCityName)'")
        
        //if  city does not exist
        if existCity.isEmpty {
            let province = ProvincestateRealm()
            
            province.province = newData.provincestate ?? "Unknow city"
            province.confirmed = newData.confirmed ?? 0
            province.deaths = newData.deaths ?? 0
            province.recovered = newData.recovered ?? 0
            
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
}
