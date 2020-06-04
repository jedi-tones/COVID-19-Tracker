//
//  ChooseLocationViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 15.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseLocationViewController: UIViewController {

    let realm = try! Realm()
    weak var delegate: UpdateFavCountry?
    
    @IBOutlet var countryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUI()
    }
    
    private func setUI(){
        countryTableView.register(UINib(nibName: "ChooseCountryTableViewCell", bundle: nil), forCellReuseIdentifier: ChooseCountryTableViewCell.reuseID)
    }

}

extension ChooseLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.objects(VirusRealm.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseCountryTableViewCell.reuseID, for: indexPath) as! ChooseCountryTableViewCell
        
        cell.countryLabel.text = realm.objects(VirusRealm.self)[indexPath.row].countryregion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        let newCountry = realm.objects(VirusRealm.self)[indexPath.row].countryregion
        UserSettings.shared.changeFavoriteCountry(newCountry: newCountry)
        
        delegate?.update()
        dismiss(animated: true, completion: nil)
    }
    
}
