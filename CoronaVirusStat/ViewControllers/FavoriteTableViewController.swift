//
//  FavoriteTableViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 14.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "MY LOCATION"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
