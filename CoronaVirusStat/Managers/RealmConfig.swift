//
//  RealmConfig.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 18.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    static let shared = RealmConfig()
    
    func setDefaultRealm() {
        var config = Realm.Configuration(schemaVersion: 1,
                                         migrationBlock: { migration, oldSchemaVersion in
                                            if oldSchemaVersion < 1 {
                                                
                                            }
        })
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("coronaVirus.realm")
        
        Realm.Configuration.defaultConfiguration = config
    }
}
