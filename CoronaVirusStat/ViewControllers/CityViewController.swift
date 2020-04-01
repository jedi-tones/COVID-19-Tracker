//
//  CityViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class CityViewController: UIViewController {

    var countrySelected: VirusRealm!
    var provinceSorted: Results<ProvincestateRealm>?
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var cityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    private func setUI(){
        
        cityTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseID)
        
        navItem.title = countrySelected.countryregion
        
        provinceSorted = countrySelected.province.sorted(byKeyPath: "confirmed", ascending: false)
    }

}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countrySelected.province.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID, for: indexPath) as! CityTableViewCell
        
        cell.textLabel?.text = provinceSorted?[indexPath.row].province
        cell.detailTextLabel?.text = "\(provinceSorted?[indexPath.row].confirmed ?? 0)"
        return cell
    }
    
    
}
