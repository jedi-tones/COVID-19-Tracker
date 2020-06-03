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
    
    var userSettings: UserSettingsRealm?
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "closeChooseSegue" else { return }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSettings()
        registerCell()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chooseFavCountry()
        tableView.reloadData()
    }
    
    
    
    private func getSettings() {
        userSettings = realm.objects(UserSettingsRealm.self).filter("id == 1").first
    }
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "MY LOCATION"
    }
    
    private func registerCell(){
        tableView.register(UINib(nibName: "BriefTableViewCell", bundle: nil), forCellReuseIdentifier: BriefTableViewCell.reuseID)
        tableView.register(UINib(nibName: "PieChartBriefCell", bundle: nil), forCellReuseIdentifier: PieChartBriefCell.reuseID)
        tableView.register(UINib(nibName: "LineChartBriefCell", bundle: nil), forCellReuseIdentifier: LineChartBriefCell.reuseID)
        tableView.register(UINib(nibName: "NeedChooseTableViewCell", bundle: nil), forCellReuseIdentifier: NeedChooseTableViewCell.reuseID)
    }
    
    private func chooseFavCountry(){
        
        guard let config = realm.objects(UserSettingsRealm.self).filter("id == 1").first  else { return }
        if config.firstLaunchApp  {
            performSegue(withIdentifier: "ChooseLocation", sender: nil)
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch userSettings?.firstLaunchApp {
        case true:
           return 1
        default:
           return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCountry = realm.objects(VirusRealm.self).filter("countryregion = '\(userSettings?.favoriteCountry ?? "")'").first
        
        switch indexPath.row {
        case 0:
            if userSettings?.firstLaunchApp ?? true {
               let cell = tableView.dequeueReusableCell(withIdentifier: NeedChooseTableViewCell.reuseID, for: indexPath) as! NeedChooseTableViewCell
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: BriefTableViewCell.reuseID, for: indexPath) as! BriefTableViewCell
                cell.setCell(typeOfData: .country, realmData: newCountry)
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PieChartBriefCell.reuseID, for: indexPath) as! PieChartBriefCell
            cell.setChartUI()
            cell.setChartData(typeOfData: .country, realmData: newCountry)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: LineChartBriefCell.reuseID, for: indexPath) as! LineChartBriefCell
            cell.setChartUI()
            cell.setChartData(typeOfData: .country, realmData: newCountry)
            return cell
        }
    }
    
}
