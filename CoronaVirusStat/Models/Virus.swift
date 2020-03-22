//
//  Virus.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


struct Location: Decodable {
    let lat, lng: Double?
}

struct Countrycode: Decodable {
    let iso2, iso3: String?
}

struct Timesery: Decodable {
    let confirmed, deaths, recovered: Int?
}

struct CoronaVirusStateLatest: Decodable {
    let provincestate: String?
    let countryregion: String?
    let confirmed: Int?
    let deaths: Int?
    let recovered: Int?
    let lastupdate: String?
    let location: Location?
    let countrycode: Countrycode?
}

struct CoronaVirusStateTimeSeries: Decodable {
    let countryregion: String?
    let lastupdate: String?
    let location: Location
    let countrycode: Countrycode?
    let timeseries: [String: Timesery]
}

struct CoronaVirusStateOnlyCountry: Decodable {
    let countryregion: String?
    let lastupdate: String?
    let location: Location
    let countrycode: Countrycode?
    let confirmed, deaths, recovered: Int?
}
