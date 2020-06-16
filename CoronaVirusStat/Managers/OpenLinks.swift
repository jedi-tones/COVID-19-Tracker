//
//  OpenLinks.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 16.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import UIKit

class OpenLinks {
    
    static let shared = OpenLinks()
    
    func open(service: ContactServices) {
        
        guard let webURL = NSURL(string: service.rawValue) else { return }
        UIApplication.shared.open(webURL as URL, options: [:], completionHandler: nil)
    }
}

