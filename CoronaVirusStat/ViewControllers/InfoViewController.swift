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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func showMenu() {
        
    
    }
}
