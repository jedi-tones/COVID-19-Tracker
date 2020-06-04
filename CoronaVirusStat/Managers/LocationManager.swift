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

class LocationManager: UIResponder {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var mapItem: MKMapItem? = nil
    private var nameOfCountry = ""
    
    private func setDelegate(){
        locationManager.delegate = self
    }
    
    func getLocation() -> String {
        
        setDelegate()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        return nameOfCountry
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
                self.nameOfCountry = placemark.country ?? ""
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
