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
    var delegateCountry: UpdateCountry?
    var delegateBrief: UpdateBreaf?
    
    //MARK: - getData
    
    func getBreaf(){
        
        jsonManager.getData(link: VirusDataLink.shared.linkBrief,
                            typeData: Brief.self,
                            complition: { data in
                                SaveToRealm.shared.addBrief(newData: data, complition: {
                                    
                                    DispatchQueue.main.async {
                                        self.delegateBrief?.updateBreafChart()
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
            self.delegateCountry?.updateStatus(status: true)
            self.delegateCountry?.updateTable()
            print("StartUpdateTimeSeries")
        }
        
        jsonManager.getData(link: VirusDataLink.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data, complition: {
                                    
                                    DispatchQueue.main.async {
                                        self.delegateCountry?.updateStatus(status: false)
                                        self.delegateCountry?.updateTable()
                                        print("SaveTimeseries")
                                    }
                                    
                                    //after download timeSeries, calculate timesSeries for Breaf
                                    CalculateTimeSeriesBrief.getTimeSeriesBrief(complition: {
                                        
                                        DispatchQueue.main.async {
                                            self.delegateBrief?.updateBreafChart()
                                         
                                        }
                                    })
                                    
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

