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
    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var reverseSortSegmentedControl: UISegmentedControl!
    
    let jsonManager = JsonManager()
    let realm = try! Realm()
    
    var countryRealmData: Results<VirusRealm>?
    
   
    
    
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
    
    //MARK: - sortRealmData
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
    
    //MARK: - getData
    private func getData(){
        
        jsonManager.getData(view: self,
                            link: VirusData.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveLatestOnlyCountry(data: data, complition: {
                                    DispatchQueue.main.async {
                                        self.sortRealmData()
                                        self.getCityData()
                                        self.getTimeSeriesData()
                                        
                                    }
                                })
                                                                
                                                                
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

//MARK: - navigation
extension CountryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = sender as? IndexPath else { return }
        if segue.identifier == "ShowCity" {
            let selectedCountry = countryRealmData?[indexPath.row]
            let dstVC = segue.destination as? CityViewController
            dstVC?.countrySelected = selectedCountry
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryRealmData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseID, for: indexPath)
        if let countryData = countryRealmData?[indexPath.row] {
            cell.textLabel?.text = countryData.countryregion
            cell.detailTextLabel?.text = "\(countryData.confirmed)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowCity", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
}
