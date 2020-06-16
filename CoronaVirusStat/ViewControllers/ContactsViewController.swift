//
//  ContactViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 14.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    var delegate: MenuDelegate!
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        delegate.menuPressed(menu: MenuList.contactUs)
    }
    
    @IBAction func telegramPressed(_ sender: Any) {
        
        OpenLinks.shared.open(service: .telegram)
    }
    
    @IBAction func mailPressed(_ sender: Any) {
        
        OpenLinks.shared.open(service: .mail)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
