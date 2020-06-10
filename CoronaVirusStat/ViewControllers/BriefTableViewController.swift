//
//  BriefTableViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 09.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class BriefTableViewController: UITableViewController {
    
    let jsonManager = JsonManager()
    let realm = try! Realm()
    var isUpdating = false
    
    @IBAction func updateButton(_ sender: Any) {
        getBreaf()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setUI()
        getBreaf()
        GetData.shared.delegateBrief = self
    }
    
    
    private func registerCell(){
        tableView.register(UINib(nibName: "BriefTableViewCell", bundle: nil), forCellReuseIdentifier: BriefTableViewCell.reuseID)
        tableView.register(UINib(nibName: "PieChartBriefCell", bundle: nil), forCellReuseIdentifier: PieChartBriefCell.reuseID)
        tableView.register(UINib(nibName: "LineChartBriefCell", bundle: nil), forCellReuseIdentifier: LineChartBriefCell.reuseID)
    }
    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "COVID-19"
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BriefTableViewCell.reuseID, for: indexPath) as! BriefTableViewCell
            cell.setCell(typeOfData: .brief, realmData: nil)
            if isUpdating {
                cell.setLoadTimeSeries()
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PieChartBriefCell.reuseID, for: indexPath) as! PieChartBriefCell
            cell.setChartUI()
            cell.setChartData(typeOfData: .brief, realmData: nil)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: LineChartBriefCell.reuseID, for: indexPath) as! LineChartBriefCell
            cell.setChartUI()
            cell.setChartData(typeOfData: .brief, realmData: nil)
            return cell
        }
    }
    
    //MARK:  getBreaf
    private func getBreaf(){
        GetData.shared.getBreaf()
        GetData.shared.getData()
    }
}

extension BriefTableViewController: UpdateCountry {
    func updateTable() {
        tableView.reloadData()
    }
    
    func updateStatus(status: Bool) {
        isUpdating = status
    }
    
   
}
