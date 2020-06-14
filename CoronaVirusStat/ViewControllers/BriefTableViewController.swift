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
    var isShowMenu = false
    
    let width = UIScreen.main.bounds.size.width
    let hight = UIScreen.main.bounds.size.height
    
    var menuVC: MenuViewController?
    
    @IBAction func updateButton(_ sender: Any) {
        getBreaf()
    }
    
    @IBAction func menuButton(_ sender: Any) {
        if isShowMenu {
            hideMenu()
        } else {
            showMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setUI()
        getBreaf()
        
    }
    
    //MARK:  registerCell
    private func registerCell(){
        tableView.register(UINib(nibName: "BriefTableViewCell", bundle: nil), forCellReuseIdentifier: BriefTableViewCell.reuseID)
        tableView.register(UINib(nibName: "PieChartBriefCell", bundle: nil), forCellReuseIdentifier: PieChartBriefCell.reuseID)
        tableView.register(UINib(nibName: "LineChartBriefCell", bundle: nil), forCellReuseIdentifier: LineChartBriefCell.reuseID)
    }
    
    private func setUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "COVID-19"
        
    }
    
    //MARK:  getBreaf
      private func getBreaf(){
          GetData.shared.delegateBrief = self
          GetData.shared.getBreaf()
          GetData.shared.getData()
      }
    
    // MARK: showMenu
    private func showMenu(){
        
        if menuVC == nil {
            menuVC = self.storyboard?.instantiateViewController(identifier: "MenuVC") as? MenuViewController
        }
        
        guard let menu = self.menuVC else { return }
        menu.view.frame = CGRect(x: -self.width, y: 0, width: self.width, height: self.hight)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
    
                        menu.view.frame = CGRect(x: 0, y: 0, width: self.width, height: self.hight)
                        self.view.addSubview(menu.view)
                        self.addChild(menu)
        }) { (complite) in
            self.isShowMenu.toggle()
        }
    }
    
    // MARK: hideMenu
    private func hideMenu(){
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        guard let menu = self.menuVC else { return }
                        menu.view.frame = CGRect(x: -self.width, y: 0, width: self.width, height: self.hight)
        }) { (complite) in
            self.menuVC?.view.removeFromSuperview()
            self.isShowMenu.toggle()
        }
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
    
  
}

extension BriefTableViewController: UpdateCountry {
    func updateTable() {
        tableView.reloadData()
    }
    
    func updateStatus(status: Bool) {
        isUpdating = status
    }
    
   
}
