//
//  UserSettings.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 15.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift

class UserSettings {
    
    static let shared = UserSettings()
    let realm = try! Realm()
    
    func startConfig(){
        
        do {
            try realm.write{
                //self.realm.add(brief, update: .modified)
                realm.create(UserSettingsRealm.self,
                                  value: ["id": 1],
                                  update: .modified  )
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeFavoriteCountry(newCountry: String) {
        do {
            try realm.write{
                //self.realm.add(brief, update: .modified)
                realm.create(UserSettingsRealm.self,
                                  value: ["id": 1,
                                          "firstLaunchApp": false,
                                          "favoriteCountry": newCountry],
                                  update: .modified  )
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func changeCurrentCountryCode(newCode: String) {
        do {
            try realm.write {
                realm.create(UserSettingsRealm.self, value: [ "id": 1,
                                                              "currentCountryCode": newCode],
                             update: .modified)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}
