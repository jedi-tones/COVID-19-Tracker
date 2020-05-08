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
    let numberOfCharts = 2
    
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var cityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    private func setUI(){
        
        
        cityTableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.reuseID)
        cityTableView.register(UINib(nibName: "PieChartBriefCell", bundle: nil), forCellReuseIdentifier: PieChartBriefCell.reuseID)
        cityTableView.register(UINib(nibName: "LineChartBriefCell", bundle: nil), forCellReuseIdentifier: LineChartBriefCell.reuseID)
        
        navItem.title = countrySelected.countryregion
        
        provinceSorted = countrySelected.province.sorted(byKeyPath: "confirmed", ascending: false)
    }
    
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrySelected.province.count + numberOfCharts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PieChartBriefCell.reuseID, for: indexPath) as! PieChartBriefCell
            cell.setChartData(typeOfData: .city, realmData: countrySelected)
            cell.setChartUI()
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LineChartBriefCell.reuseID, for: indexPath) as! LineChartBriefCell
            cell.setChartData(typeOfData: .city, realmData: countrySelected)
            cell.setChartUI()
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID, for: indexPath) as! CityTableViewCell
            
            cell.textLabel?.text = provinceSorted?[indexPath.row - numberOfCharts].province
            cell.detailTextLabel?.text = "\(provinceSorted?[indexPath.row - numberOfCharts].confirmed ?? 0)"
            return cell
        }
    }
}
