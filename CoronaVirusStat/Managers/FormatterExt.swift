//
//  FormatterExt.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 12.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Double {
    var formattedWithSeparator: String {
        Formatter.withSeparator.string(from: NSNumber(value: self)) ?? ""
    }
}
