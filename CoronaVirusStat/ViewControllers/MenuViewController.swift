//
//  MenuViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 13.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let numberOfStaticRows = MenuList.allCases.count
    var delegate: MenuDelegate!

    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var tableViewMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setVersion()
    }
  
    private func registerCell(){
        tableViewMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: MenuTableViewCell.reuseID)
    }
    
    private func setVersion(){
        versionLabel.text = "VERSION: .\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? 0)"
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "InfoSegue":
            let dstVC = segue.destination as! InfoViewController
            dstVC.delegate = self.delegate
        default:
            let dstVC = segue.destination as! ContactsViewController
            dstVC.delegate = self.delegate
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfStaticRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID, for: indexPath) as! MenuTableViewCell
        
        cell.textLabel?.text = MenuList.allCases[indexPath.row].rawValue
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            delegate.menuPressed(menu: MenuList.statistics)
        case 1:
            delegate.menuPressed(menu: MenuList.information)
        default:
            delegate.menuPressed(menu: MenuList.contactUs)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
