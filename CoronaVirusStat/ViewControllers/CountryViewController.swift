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
    
    
}


