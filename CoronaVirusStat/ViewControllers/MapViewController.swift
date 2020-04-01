//
//  MapViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let realm = try! Realm()
    let annotaionIdentifier = "annotaionIdentifier"
    var annotaions:[MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupPlaceMark()
        
    }
    
    
    private func setupPlaceMark() {
        let realmData = realm.objects(VirusRealm.self)
        print(#function)
        for country in realmData {
            for city in country.province {
                let newAnnotation = MKPointAnnotation()
                let confirmed = city.confirmed
                
                newAnnotation.title = " \(country.countryregion) \(city.province )"
                newAnnotation.subtitle = "Confirmed: \(city.confirmed), death: \(city.deaths), recovered: \(city.recovered)"
                
                guard let lat = city.location.first?.lat else { return }
                guard let lng = city.location.first?.lng else { return }
                
                let newCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat),
                                                           longitude: CLLocationDegrees(lng))
                newAnnotation.coordinate = newCoordinate
                
                if confirmed == 0 {
                    let overlay =  MKCircle(center: newAnnotation.coordinate, radius: Double( 0 ))
                    mapView?.addOverlay(overlay)
                } else if confirmed < 1000 {
                    let overlay =  MKCircle(center: newAnnotation.coordinate, radius: Double( confirmed * 150 ))
                    mapView?.addOverlay(overlay)
                } else if confirmed < 10000 {
                    let overlay =  MKCircle(center: newAnnotation.coordinate, radius: Double( confirmed * 40 ))
                    mapView?.addOverlay(overlay)
                } else {
                    let overlay =  MKCircle(center: newAnnotation.coordinate, radius: Double( confirmed * 20 ))
                    mapView?.addOverlay(overlay)
                }
                annotaions.append(newAnnotation)
            }
        }
        mapView.addAnnotations(annotaions)
        mapView.showAnnotations(annotaions, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotaionIdentifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotaionIdentifier)
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
          let renderer = MKCircleRenderer(overlay: overlay)
          renderer.fillColor = UIColor.red.withAlphaComponent(0.3)
          renderer.strokeColor = UIColor.red
          renderer.lineWidth = 1
          
          return renderer
      }
}
