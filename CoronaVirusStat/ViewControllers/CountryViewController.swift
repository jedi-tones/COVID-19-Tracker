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
    
    private let jsonManager = JsonManager()
    
    private let realm = try! Realm()
    private var countryRealmData: Results<VirusRealm>?
    private var filterCountryRealmData: Results<VirusRealm>?
    private var brief: Results<BriefRealm>?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var isEmptySearchBar: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isSearching: Bool {
        !isEmptySearchBar && searchController.isActive
    }
    
    private var typeFilter: TypeOfFilter = .confirmed
    private var isAscending = false
    private var isUpdatingTimeSeries = false
    
    private var myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryRealmData = realm.objects(VirusRealm.self)
        brief = realm.objects(BriefRealm.self)
        
        registerCell()
        setUI()
        
        sortRealmData(filter: typeFilter, ascending: isAscending)
        
        GetData.shared.delegateCountry = self
    }
    
    @IBAction func renewPressed() {
        GetData.shared.getData()
    }
    
    //MARK:- setUI
    private func setUI(){
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type country.."
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "ALL COUNTRY"
        
        definesPresentationContext = true
        
        
        myRefreshControl.addTarget(self, action: #selector(refresh(selector:)), for: .valueChanged)
        countryTableView.refreshControl = myRefreshControl
        
        //   countryTableView.tableHeaderView = searchController.searchBar
    }
    
    @objc private func refresh(selector: UIRefreshControl){
        GetData.shared.getData()
        selector.endRefreshing()
    }
    
    private func registerCell(){
        countryTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: CountryTableViewCell.reuseID)
        countryTableView.register(UINib(nibName: "FirstCountryTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderCountryTableView.reuseID)
    }
    
    //MARK: - sortRealmData
    func sortRealmData(filter: TypeOfFilter, ascending: Bool) {
        //  let isReverse = reverseSortSegmentedControl.selectedSegmentIndex == 0 ? false : true
        
        switch filter {
        case .confirmed:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "confirmed", ascending: ascending)
        case .death:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "deaths", ascending: ascending)
        case .deathPercent:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "percentDeath", ascending: ascending)
        case .recoveredPercent:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "percentRecovered", ascending: ascending)
        default:
            countryRealmData = realm.objects(VirusRealm.self).sorted(byKeyPath: "countryregion", ascending: !ascending)
        }
        guard let indexPath = countryTableView.indexPathsForVisibleRows else { return }
        countryTableView.reloadRows(at: indexPath, with: .fade)
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
    
    //MARK:  Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseID, for: indexPath) as! CountryTableViewCell
        
        if isSearching {
            if let countryData = filterCountryRealmData?[indexPath.row] {
                cell.setCell(data: countryData) }
        } else {
            if let countryData = countryRealmData?[indexPath.row] {
                cell.setCell(data: countryData)
            }
        }
        
        if isUpdatingTimeSeries {
            cell.setLoadTimeSeries()
        }
        return cell
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCountryTableView.reuseID) as! HeaderCountryTableView
        
        headerCell.delegate = self
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
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
    }
    
    private func filterContentSearch(searchText: String) {
        filterCountryRealmData = realm.objects(VirusRealm.self).filter("countryregion CONTAINS[c] '\(searchText.lowercased())'")
    }
}


//MARK: - SortDelegate sorting
extension CountryViewController: SortDelegate {
    func sorting(typeOfFilter: TypeOfFilter, ascending: Bool) {
        typeFilter = typeOfFilter
        isAscending = ascending
        
        sortRealmData(filter: typeOfFilter, ascending: ascending)
    }
}

extension CountryViewController: UpdateCountry {
    func updateStatus(status: Bool) {
        isUpdatingTimeSeries = status
    }
    
    func updateTable() {
        countryTableView.reloadData()
    }
}
