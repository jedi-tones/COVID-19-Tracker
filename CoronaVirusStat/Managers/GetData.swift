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
    
    //MARK: - getData
    func getData(){
        
        jsonManager.getData(link: VirusDataLink.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                //download and save all Country info
                                SaveToRealm.shared.saveLatestOnlyCountry(data: data, complition: {
                                    DispatchQueue.main.async {
                                        self.delegateCountry?.updateTable()
                                        self.delegateCountry?.updateStatus(status: true)
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
        
        jsonManager.getData(link: VirusDataLink.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data, complition: {
                                    
                                    self.delegateCountry?.updateStatus(status: false)
                                    DispatchQueue.main.async {
                                        self.delegateCountry?.updateTable()
                                    }
                                    
                                    //after download timeSeries, calculate timesSeries for Breaf
                                    CalculateTimeSeriesBrief.getTimeSeriesBrief(complition: {})
                                    
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

