//
//  CityViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    var countrySelected: VirusRealm!
    
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var cityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    private func setUI(){
        
        cityTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseID)
        
        navItem.title = countrySelected.countryregion
        print(countrySelected.province.count)
    }

}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countrySelected.province.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID, for: indexPath) as! CityTableViewCell
        
        cell.textLabel?.text = countrySelected.province[indexPath.row].province
        cell.detailTextLabel?.text = "\(countrySelected.province[indexPath.row].confirmed)"
        return cell
    }
    
    
}
