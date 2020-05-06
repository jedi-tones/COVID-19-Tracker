//
//  FirstCountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 31.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class FirstCountryTableViewCell: UITableViewCell {

    @IBOutlet var sortSegmentedControl: UISegmentedControl!
    @IBOutlet var reversSortSwitch: UISwitch!
    
    static let reuseID = "firstCountryCell"
    private var typeOfFilter: TypeOfFilter = .Confirmed
    private var isAscending = false
    
    var delegate:SortDelegate?
    
    
    @IBAction func changeSortAction() {
        
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            typeOfFilter = .Confirmed
        case 1:
            typeOfFilter = .Death
        default:
            typeOfFilter = .Country
        }
        
        delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
    }
    
    
    @IBAction func changeAscending() {
        isAscending = reversSortSwitch.isOn
        delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
