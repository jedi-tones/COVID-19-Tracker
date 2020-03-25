//
//  CountryViewController.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 21.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift

class CountryViewController: UIViewController {
    
    @IBOutlet var countryTableView: UITableView!
    
    
    let jsonManager = JsonManager()
    let realm = try! Realm()
    
    var countryRealmData: Results<VirusRealm>?
    
    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var reverseSortSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryRealmData = realm.objects(VirusRealm.self)

        setUI()
        getData()
        sortRealmData()
    }
    
    @IBAction func renewPressed() {
        getData()
    }
    @IBAction func sortChanged() {
        sortRealmData()
    }
    
    @IBAction func reverseSortChanged() {
        sortRealmData()
    }
    
    private func setUI(){
        
        countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: CountryTableViewCell.reuseID)
        
    }
    
    
    private func sortRealmData() {
        let isReverse = reverseSortSegmentedControl.selectedSegmentIndex == 0 ? false : true
        
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "confirmed", ascending: isReverse)
            
        case 1:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "deaths", ascending: isReverse)
        default:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "countryregion", ascending: !isReverse)
        }
        countryTableView.reloadData()
        
    }
    
    private func getData(){
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveLatestOnlyCountry(data: data, complition: {
                                    DispatchQueue.main.async {
                                        self.sortRealmData()
                                    }
                                })
                                //                                self.getCityData()
                                //                                self.getTimeSeriesData()
                                //                                self.getTimeSeriesForCity(countryCode: "US")
        })
    }
    
    private func getCityData(){
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkLatest,
                            typeData: [CoronaVirusStateLatest].self,
                            complition: {data in
                                
                                SaveToRealm.shared.saveLatestCity(data: data)
        })
    }
    
    private func getTimeSeriesData() {
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data)
        })
    }
    
    private func getTimeSeriesForCity(countryCode: String){
        
        let linkCurrentCountry = VirusData.shared.linkTimeSeriesCityCode + countryCode
        jsonManager.getData(view: self,
                            link: linkCurrentCountry,
                            typeData: [CoronaVirusCityTimesSeries].self,
                            complition: { data in
                                SaveToRealm.shared.saveTimeSeriesCity(data: data)
        })
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryRealmData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseID, for: indexPath) as! CountryTableViewCell
        if let countryData = countryRealmData?[indexPath.row] {
            cell.textLabel?.text = countryData.countryregion
            cell.detailTextLabel?.text = "\(countryData.deaths)"
        }
        
        return cell
    }
    
    
}
