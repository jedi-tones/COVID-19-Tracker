//
//  GetData.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 26.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


class GetData {
    
    static let shared = GetData()
    private let jsonManager = JsonManager()
    weak var delegateCountry: UpdateCountry?
    weak var delegateBrief: UpdateCountry?
    weak var delegateFavCountry: UpdateCountry?
    
    //MARK: - getData
    
    func getBreaf(){
        
        jsonManager.getData(link: VirusDataLink.shared.linkBrief,
                            typeData: Brief.self,
                            complition: { data in
                                SaveToRealm.shared.addBrief(newData: data, complition: {
                                    
                                    DispatchQueue.main.async {
                                        self.delegateBrief?.updateTable()
                                    }
                                })
        })
    }
    
    
    func getData(){
        
        jsonManager.getData(link: VirusDataLink.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                //download and save all Country info
                                SaveToRealm.shared.saveLatestOnlyCountry(data: data, complition: {
                                    DispatchQueue.main.async {
                                        self.delegateCountry?.updateTable()
                                        self.delegateFavCountry?.updateTable()
                                    }
                                    self.getCityData()
                                    self.getTimeSeriesData()
                                })
                                
                                //                                self.getTimeSeriesForCity(countryCode: "US")
        })
    }
    
    //MARK:  getCityData
    func getCityData(){
        
        jsonManager.getData(link: VirusDataLink.shared.linkLatest,
                            typeData: [CoronaVirusStateLatest].self,
                            complition: {data in
                                
                                SaveToRealm.shared.saveLatestCity(data: data)
        })
    }
    
    //MARK:  getTimeSeriesData
    func getTimeSeriesData() {
        
        DispatchQueue.main.async {
            self.delegateBrief?.updateStatus(status: true)
            self.delegateBrief?.updateTable()
            
            self.delegateCountry?.updateStatus(status: true)
            self.delegateCountry?.updateTable()
            
            self.delegateFavCountry?.updateStatus(status: true)
            self.delegateFavCountry?.updateTable()
            print("StartUpdateTimeSeries")
        }
        
        jsonManager.getData(link: VirusDataLink.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data, complition: {
                                    
                                    //calculate new stats for 1 day
                                    Statistic.getAddNewStats {
                                        
                                        //update country VC
                                        DispatchQueue.main.async {
                                            self.delegateCountry?.updateStatus(status: false)
                                            self.delegateCountry?.updateTable()
                                            
                                            self.delegateFavCountry?.updateStatus(status: false)
                                            self.delegateFavCountry?.updateTable()
                                            print("SaveTimeseries")
                                        }
                                        
                                        //after download timeSeries, calculate timesSeries for Breaf
                                        
                                        CalculateTimeSeriesBrief.getTimeSeriesBrief(complition: {
                                            DispatchQueue.main.async {
                                                self.delegateBrief?.updateStatus(status: false)
                                                self.delegateBrief?.updateTable()
                                            }
                                        })
                                    }
                                    
                                })
                                
        })
    }
    
    //MARK:  getTimeSeriesForCity
    //    private func getTimeSeriesForCity(countryCode: String){
    //
    //        let linkCurrentCountry = VirusDataLink.shared.linkTimeSeriesCityCode + countryCode
    //        jsonManager.getData(view: self,
    //                            link: linkCurrentCountry,
    //                            typeData: [CoronaVirusCityTimesSeries].self,
    //                            complition: { data in
    //                                SaveToRealm.shared.saveTimeSeriesCity(data: data)
    //        })
    //    }
    
}

