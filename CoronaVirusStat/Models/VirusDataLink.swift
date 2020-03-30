//
//  VirusDataLink.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation

class VirusDataLink {
    static let shared = VirusDataLink()
    
    let linkLatest = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest"
    let linkLatestOnlyCountry = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/latest?onlyCountries=true"
    let linkTimeSeriesOnlyCountry = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?onlyCountries=true"
    let linkTimeSeriesCityCode = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?iso2="
    let linkBrief = "https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/brief"
    
    
}
