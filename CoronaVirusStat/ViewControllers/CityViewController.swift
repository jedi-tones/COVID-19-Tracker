//
//  CityViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    var country: String!
    var countryCode: String!
    
    
    @IBOutlet var navItem: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = country
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
