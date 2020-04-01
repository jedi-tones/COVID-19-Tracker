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
    
    private let jsonManager = JsonManager()
    private let realm = try! Realm()
    private let searchController = UISearchController(searchResultsController: nil)
    private var countryRealmData: Results<VirusRealm>?
    private var filterCountryRealmData: Results<VirusRealm>?
    
    private var isEmptySearchBar: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isSearching: Bool {
         !isEmptySearchBar && searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryRealmData = realm.objects(VirusRealm.self)
        
        registerCell()
        setUI()
        getBreaf()
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
    
    //MARK:- setUI
    private func setUI(){
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search country"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func registerCell(){
        countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: CountryTableViewCell.reuseID)
        countryTableView.register(UINib(nibName: "FirstCountryTableViewCell", bundle: nil), forCellReuseIdentifier: FirstCountryTableViewCell.reuseID)
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
                            link: VirusDataLink.shared.linkLatestOnlyCountry,
                            typeData: [CoronaVirusStateOnlyCountry].self,
                            complition: { data in
                                
                                //download and save all Country info
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
    
    private func getBreaf(){
        
        jsonManager.getData(view: self,
                            link: VirusDataLink.shared.linkBrief,
                            typeData: Breaf.self,
                            complition: { data in
                                SaveToRealm.shared.addBreaf(newData: data, complition: {
                                    DispatchQueue.main.async {
                                        self.countryTableView.reloadData()
                                 //       self.countryTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                                    }
                                })
        })
    }
    
    private func getCityData(){
        
        jsonManager.getData(view: self,
                            link: VirusDataLink.shared.linkLatest,
                            typeData: [CoronaVirusStateLatest].self,
                            complition: {data in
                                
                                SaveToRealm.shared.saveLatestCity(data: data)
        })
    }
    
    private func getTimeSeriesData() {
        
        jsonManager.getData(view: self,
                            link: VirusDataLink.shared.linkTimeSeriesOnlyCountry,
                            typeData: [CoronaVirusStateTimeSeries].self,
                            complition: { data in
                                
                                SaveToRealm.shared.saveTimeSeriesOnlyCountry(data: data, complition: {
                                    DispatchQueue.main.async {
                                        self.countryTableView.reloadData()
                                        
                                        //after download timeSeries, calculate timesSeries for Breaf
                                        SaveToRealm.shared.getTimeSeriesBreaf(complition: {
                                            self.countryTableView.reloadData()
                                        })
                                    }
                                })
                                
        })
    }
    
    private func getTimeSeriesForCity(countryCode: String){
        
        let linkCurrentCountry = VirusDataLink.shared.linkTimeSeriesCityCode + countryCode
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
            let dstVC = segue.destination as? CityViewController
            if isSearching {
                let selectedCountry = filterCountryRealmData?[indexPath.row]
                dstVC?.countrySelected = selectedCountry
            } else {
                let selectedCountry = countryRealmData?[indexPath.row]
                dstVC?.countrySelected = selectedCountry
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filterCountryRealmData?.count ?? 0
        } else {
            return countryRealmData?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstCountryTableViewCell.reuseID, for: indexPath) as! FirstCountryTableViewCell
            
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseID, for: indexPath) as! CountryTableViewCell
            
            if isSearching {
                if let countryData = filterCountryRealmData?[indexPath.row] {
                    cell.setCell(data: countryData) }
            } else {
                if let countryData = countryRealmData?[indexPath.row] {
                    cell.setCell(data: countryData)
                }
            }
            return cell
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowCity", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}

//MARK: - UISearchResultsUpdating
extension CountryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentSearch(searchText: searchController.searchBar.text ?? "")
        countryTableView.reloadData()
        print(#function)
        
    }
    
    private func filterContentSearch(searchText: String) {
        filterCountryRealmData = realm.objects(VirusRealm.self).filter("countryregion CONTAINS[c] '\(searchText.lowercased())'")
    }
}
