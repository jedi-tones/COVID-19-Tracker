//
//  AlertController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AlertController: UIViewController {
    
    static let shared = AlertController()
    
    func showErrorAlert(titleAlert: String, messageAlert: String) {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)

        let closeAction = UIAlertAction(title: "OK", style: .default) { _ in }
        
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
    func showChooseCountryAlert(country: String, segueIndetifier: String, currentTableView: UITableViewController) {
        
        
        let realm = try! Realm()
        let titleAlert = "Confirm country"
        let messageAlert = "Your country is \(country)?"
        
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .actionSheet)
        //save CLLocation country
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
            
            do {
                try realm.write {
                    realm.create(UserSettingsRealm.self, value: ["id": 1,
                                                                 "firstLaunchApp" : false,
                                                                 "favoriteCountry": country], update: .modified)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            currentTableView.tableView.reloadData()
        }
        
        //present Choose country VC
        let chooseCountryAction = UIAlertAction(title: "Choose country", style: .default) { _ in
            
            currentTableView.performSegue(withIdentifier: segueIndetifier, sender: nil)
        }
        
        alert.addAction(okAction)
        alert.addAction(chooseCountryAction)
        currentTableView.present(alert, animated: true, completion: nil)
    }
    
}
