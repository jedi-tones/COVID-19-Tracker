//
//  VirusData.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation

class VirusData {
    static let shared = VirusData()
    
    let linkLatest = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest"
    let linkLatestOnlyCountry = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest?onlyCountries=true"
    let linkTimeSeries = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?onlyCountries=true"
    let linkBrief = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/brief"
    
    
    private var virusDataState = [CoronaVirusStateLatest]()
    private var virusDataStateOnlyCountry = [CoronaVirusStateOnlyCountry]()
    private var virusDataStateTimeSeries = [CoronaVirusStateTimeSeries]()
    
    
    func saveOnlyCountry(data: [CoronaVirusStateOnlyCountry] ){
        virusDataStateOnlyCountry = data
    }
    
    func saveTimeSeries(data: [CoronaVirusStateTimeSeries] ){
        virusDataStateTimeSeries = data
    }
    
    func saveOnlyCountry(data: [CoronaVirusStateLatest] ){
        virusDataState = data
    }
    
    
    
}
