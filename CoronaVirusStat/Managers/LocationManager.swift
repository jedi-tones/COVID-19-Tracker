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
    
    private func setDelegate(){
        locationManager.delegate = self
    }
    
    func getLocation() {
        
        setDelegate()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error: Error?) in
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                guard  let coordinate = placemark.location?.coordinate else { return }
                self.mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
                
                UserSettings.shared.changeCurrentCountryCode(newCode: placemark.isoCountryCode ?? "")
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
