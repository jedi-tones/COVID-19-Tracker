//
//  ConverterDate.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 27.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation

class ConvertDate {
    
    //conver date form m/DD/yyyy to yyyy/m/DD
    static func convertToYyMmDd(oldDate: String) -> String {
        let getDateFormatter = DateFormatter()
        getDateFormatter.dateFormat = "M/dd/yy"
        let setDateFormater = DateFormatter()
        setDateFormater.dateFormat = "yy/M/dd"
        let oldDateDate = getDateFormatter.date(from: oldDate)
        guard let date = oldDateDate else { return "20/03/25" }
        return setDateFormater.string(from: date)
    }
    
    static func convertToMmDdYy(oldDate: String) -> String {
        let getDateFormatter = DateFormatter()
        getDateFormatter.dateFormat = "yy/M/dd"
        let setDateFormater = DateFormatter()
        setDateFormater.dateFormat = "M/dd/yy"
        let oldDateDate = getDateFormatter.date(from: oldDate)
        guard let date = oldDateDate else { return "3/29/20" }
        return setDateFormater.string(from: date)
    }
}
