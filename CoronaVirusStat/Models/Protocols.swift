//
//  Protocols.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 02.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation


//countryVC
protocol SortDelegate: class {
    func sorting(typeOfFilter: TypeOfFilter, ascending: Bool)
}

protocol UpdateCountry: class {
    func updateTable()
    func updateStatus(status: Bool)
}

protocol MenuDelegate: class {
    func toggleMenu()
    func menuPressed(menu: MenuList)
}
