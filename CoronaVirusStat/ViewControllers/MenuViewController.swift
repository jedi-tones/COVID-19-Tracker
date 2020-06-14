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

    @IBOutlet var tableViewMenu: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
  
    private func registerCell(){
        tableViewMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: MenuTableViewCell.reuseID)
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
    
    
}
