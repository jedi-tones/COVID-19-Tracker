//
//  AlertController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import UIKit

class AlertController: UIViewController {
    
    static let shared = AlertController()
    
    func showErrorAlert(titleAlert: String, messageAlert: String) {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)

        let closeAction = UIAlertAction(title: "OK", style: .default) { _ in
            
        }
        
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
}
