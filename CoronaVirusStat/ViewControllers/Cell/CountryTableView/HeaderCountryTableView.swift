//
//  FirstCountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 31.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class HeaderCountryTableView: UITableViewHeaderFooterView {

    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var reversSortSwitch: UISwitch!
    
    static let reuseID = "firstCountryCell"
    private var typeOfFilter: TypeOfFilter = .confirmed
    private var isAscending = false
    
    var delegate:SortDelegate?
    
    
    @IBAction func changeSortAction() {
        
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            typeOfFilter = .confirmed
        case 1:
            typeOfFilter = .death
        default:
            typeOfFilter = .сountry
        }
        
        delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
    }
    
    
    @IBAction func changeAscending() {
        isAscending = reversSortSwitch.isOn
        
        switch sortSegmentedControl.selectedSegmentIndex {
               case 0:
                   typeOfFilter = .confirmed
               case 1:
                   typeOfFilter = .death
               default:
                   typeOfFilter = .сountry
               }
        
        delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
