//
//  AlertController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    static let shared = AlertController()
    
    func showErrorAlert(view: UIViewController, titleAlert: String, messageAlert: String) {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)

        let closeAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        
        alert.addAction(closeAction)
        view.present(alert, animated: true)
    }
    
}
