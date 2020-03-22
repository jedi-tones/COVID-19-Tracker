//
//  CountryViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    let jsonManager = JsonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    
    private func getData(){
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveLatestOnlyCountry(data: data)
                                self.getCityData()
                                self.getTimeSeriesData()
                                self.getTimeSeriesForCity(countryCode: "US")
        })
    }
    
    private func getCityData(){
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkLatest,
                            typeData: [CoronaVirusStateLatest].self,
                            complition: {data in
                                
                                SaveToRealm.shared.saveLatestCity(data: data)
        })
    }
    
    private func getTimeSeriesData() {
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data)
        })
    }
    
    private func getTimeSeriesForCity(countryCode: String){
        
        let linkCurrentCountry = VirusData.shared.linkTimeSeriesCityCode + countryCode
        jsonManager.getData(view: self,
                            link: linkCurrentCountry,
                            typeData: [CoronaVirusCityTimesSeries].self,
                            complition: { data in
                                SaveToRealm.shared.saveTimeSeriesCity(data: data)
        })
    }
    
}


