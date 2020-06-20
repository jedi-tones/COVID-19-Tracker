//
//  LocationManager.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 04.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import RealmSwift

class LocationManager: UIResponder {
    
    static let shared = LocationManager()
    
    private let realm = try! Realm()
    private let locationManager = CLLocationManager()
    private var mapItem: MKMapItem? = nil
    private var currenetTableVC: UITableViewController? = nil
    private var segueToChoose: String? = nil
    
    
    private func setDelegate(){
        locationManager.delegate = self
    }
    
    func getLocation(currentVC: UITableViewController,
                     segueIndetificatorToManualChoose: String) {
        
        currenetTableVC = currentVC
        segueToChoose = segueIndetificatorToManualChoose
        
        setDelegate()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
    
    private func showConfirmAlertAndSegue() {
        
        guard let currentVC = currenetTableVC else { return }
        guard let segueIndetificator = segueToChoose else { return }
        guard let userSettings = realm.objects(UserSettingsRealm.self).filter("id == 1").first else { return }
        
            if userSettings.firstLaunchApp {
                
                guard let country = realm.objects(VirusRealm.self).filter("countrycode == '\(userSettings.currentCountryCode)'").first else {
                    if userSettings.firstLaunchApp  {
                        currentVC.performSegue(withIdentifier: segueIndetificator, sender: nil)
                    }
                    return
                }
                
                AlertController.shared.showChooseCountryAlert(country: country.countryregion, segueIndetifier: segueIndetificator, currentTableView: currentVC )
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    
    //MARK: - Update Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: Error?) in
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                guard  let coordinate = placemark.location?.coordinate else { return }
                self.mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                
                // write current country code from CLLocation to realm
                UserSettings.shared.changeCurrentCountryCode(newCode: placemark.isoCountryCode ?? "")
                
                //show Alert to confirm country or show manual choose VC
                self.showConfirmAlertAndSegue()
            }
        }
    }
    
    //MARK: - Fail CLLocation
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        guard let settings = realm.objects(UserSettingsRealm.self).filter("id == 1").first else { return }
        
        if settings.firstLaunchApp {
            guard let currentVC = currenetTableVC else { return }
            guard let segueIndetificator = segueToChoose else { return }
            
            let title = "Auto-positioning error"
            let message = error.localizedDescription
            let buttonMessage = "Choose location manual"
            AlertController.shared.showErrorLocationAlert(titleAlert: title, messageAlert: message, buttonMessage: buttonMessage, viewController: currentVC, segueIndetificatorForChooseVC: segueIndetificator)
        }
    }
}
