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
    
    @IBOutlet var detailView: DetailAnnotaion!
    
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
                
                if city.province == "No details information"  {
                    newAnnotation.title = " \(country.countryregion.uppercased())"
                } else {
                    newAnnotation.title = " \(country.countryregion.uppercased()) \(city.province.uppercased())"
                }
                
                
                newAnnotation.subtitle = """
                                            \(city.confirmed)
                                            \(city.deaths)
                                            \(city.recovered)
                                        """
                
                
                guard let lat = city.location.first?.lat else { return }
                guard let lng = city.location.first?.lng else { return }
                
                let newCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat),
                                                           longitude: CLLocationDegrees(lng))
                newAnnotation.coordinate = newCoordinate
                
                let overlay = MKCircle(center: newAnnotation.coordinate, radius: Double(confirmed))
               
                mapView?.addOverlay(overlay)
                
                annotaions.append(newAnnotation)
            }
        }
        // mapView.addAnnotations(annotaions)
        mapView.showAnnotations(annotaions, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotaionIdentifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotaionIdentifier)
            annotationView?.canShowCallout = true
            
            let detailAnnotationView = DetailAnnotaion()
            detailAnnotationView.textAnnotation.text = annotation.subtitle!
            
            annotationView?.detailCalloutAccessoryView = detailAnnotationView
            annotationView?.pinTintColor = UIColor(named: "deathStroke2") ?? .red
            
        }
        
        //annotationView?.image = UIImage(named: "pinVirus")
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
