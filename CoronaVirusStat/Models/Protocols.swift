//
//  Protocols.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 02.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation

//briefVC
protocol UpdateBreaf {
    func updateBreafChart()
}

//countryVC
protocol SortDelegate {
    func sorting(typeOfFilter: TypeOfFilter, ascending: Bool)
}

protocol UpdateCountry {
    func updateTable()
    func updateStatus(status: Bool)
}
