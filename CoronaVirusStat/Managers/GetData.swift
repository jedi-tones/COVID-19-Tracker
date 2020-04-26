//
//  GetData.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 26.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


class GetData {
    
     private let jsonManager = JsonManager()
    
        //MARK: - getData
        private func getData(){
            
            jsonManager.getData(view: self,
                                link: VirusDataLink.shared.linkLatestOnlyCountry,
                                typeData: [CoronaVirusStateOnlyCountry].self,
                                complition: { data in
                                    
                                    //download and save all Country info
                                    SaveToRealm.shared.saveLatestOnlyCountry(data: data, complition: {
                                        DispatchQueue.main.async {
                                            self.sortRealmData(filter: self.typeFilter, ascending: self.isAscending)
                                        }
                                        
                                        self.getCityData()
                                        self.isUpdatingTimeSeries = true
                                        self.getTimeSeriesData()
                                    })
                                    
                                    //                                self.getTimeSeriesForCity(countryCode: "US")
            })
        }
        
        //MARK:  getCityData
        private func getCityData(){
            
            jsonManager.getData(view: self,
                                link: VirusDataLink.shared.linkLatest,
                                typeData: [CoronaVirusStateLatest].self,
                                complition: {data in
                                    
                                    SaveToRealm.shared.saveLatestCity(data: data)
            })
        }
        
        //MARK:  getTimeSeriesData
        private func getTimeSeriesData() {
            
            jsonManager.getData(view: self,
                                link: VirusDataLink.shared.linkTimeSeriesOnlyCountry,
                                typeData: [CoronaVirusStateTimeSeries].self,
                                complition: { data in
                                    
                                    SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data, complition: {
                                        
                                        self.isUpdatingTimeSeries = false
                                        DispatchQueue.main.async {
                                            self.countryTableView.reloadData()
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
}
