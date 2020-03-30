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
        
        // Do any additional setup after loading the view.
    }
    
    
    private func setupPlaceMark() {
        let realmData = realm.objects(VirusRealm.self)
        
        for country in realmData {
            let annotation = MKPointAnnotation()
            annotation
        }
        
    }
    
}
