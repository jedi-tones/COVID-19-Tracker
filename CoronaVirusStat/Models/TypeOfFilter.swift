//
//  TypeOfFilter.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 05.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


enum TypeOfFilter: String, CaseIterable  {
    case confirmed = "CONFIRMED"
    case death = "DEATH"
    case сountry = "COUNTRY"
    case deathPercent = "DEATH %"
    case recoveredPercent = "RECOVERED %"
}

