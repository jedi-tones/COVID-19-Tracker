//
//  FavoriteTableViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 14.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteTableViewController: UITableViewController {

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chooseFavCountry()
    }
    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "MY LOCATION"
    }
    
    private func chooseFavCountry(){
        
        guard let config = realm.objects(UserSettingsRealm.self).filter("id == 1").first  else { return }
        if config.firstLaunchApp  {
            performSegue(withIdentifier: "ChooseLocation", sender: nil)
        }
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
