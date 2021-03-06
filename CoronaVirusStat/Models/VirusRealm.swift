//
//  VirusRealm.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import RealmSwift


class LocationRealm: Object {
    @objc dynamic  var lat = 0.0
    @objc dynamic  var lng = 0.0
}


class TimeseryRealm: Object {
   @objc dynamic var date = "2020"
   @objc dynamic var confirmed = 0
   @objc dynamic var deaths = 0
   @objc dynamic var recovered = 0
}

class ProvincestateRealm: Object {
   @objc dynamic var province = "Unknow city"
   @objc dynamic var confirmed = 0
   @objc dynamic var deaths = 0
   @objc dynamic var recovered = 0
    let timesSeries = List<TimeseryRealm>()
    let location = List<LocationRealm>()
}

class BriefRealm: Object {
    @objc dynamic var id = 1
    @objc dynamic var confirmed = 0
    @objc dynamic var death = 0
    @objc dynamic var recovered = 0
    @objc dynamic var differenceConfirmed = 0
    @objc dynamic var differenceDeath = 0
    @objc dynamic var differenceRecovered = 0
    @objc dynamic var lastDifferenceDate = ""
    let timesSeries = List<TimeseryRealm>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}

class VirusRealm: Object {
    @objc dynamic var countryregion = "Unknow country"
    @objc dynamic var confirmed = 0
    @objc dynamic var deaths = 0
    @objc dynamic var recovered = 0
    @objc dynamic var lastupdate = "2020-03-21T18:42:00.009Z"
    @objc dynamic var countrycode = ""
    @objc dynamic var differenceConfirmed = 0
    @objc dynamic var differenceDeath = 0
    @objc dynamic var differenceRecovered = 0
    @objc dynamic var lastDifferenceDate = ""
    @objc dynamic var percentDeath = 0.0
    @objc dynamic var percentRecovered = 0.0
    let location = List<LocationRealm>()
    let timeSeries = List<TimeseryRealm>()
    let province = List<ProvincestateRealm>()
    
    override class func primaryKey() -> String? {
        "countryregion"
    }
}

class UserSettingsRealm: Object {
    @objc dynamic var id = 1
    @objc dynamic var firstLaunchApp = true
    @objc dynamic var favoriteCountry = ""
    @objc dynamic var currentCountryCode = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
}
