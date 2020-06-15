//
//  SettingsViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 25.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var delegate: MenuDelegate!
    
    @IBAction func pressMenuButton(_ sender: Any) {
        delegate.toggleMenu()
    }
    
    @IBAction func jhuCSSEPressed(_ sender: Any) {
        
        let settingsUrl = NSURL(string:"https://github.com/CSSEGISandData/COVID-19/blob/master/README.md")! as URL
        UIApplication.shared.open(settingsUrl, options: [ : ], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
