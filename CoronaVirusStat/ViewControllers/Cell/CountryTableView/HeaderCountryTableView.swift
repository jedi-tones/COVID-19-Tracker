//
//  FirstCountryTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 31.03.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class HeaderCountryTableView: UITableViewHeaderFooterView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static let reuseID = "firstCountryCell"
    
    private var typeOfFilter: TypeOfFilter = .confirmed
    private var isAscending = true
    
    var delegate:SortDelegate?
    
    @IBOutlet var filterPicker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filterPicker.delegate = self
        filterPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return TypeOfFilter.allCases.count
        default:
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 20.0)
            pickerLabel?.textAlignment = .left
        }
        
        switch component {
        case 0:
            pickerLabel?.text = TypeOfFilter.allCases[row].rawValue
            return pickerLabel!
        default:
            pickerLabel?.textAlignment = .right
            pickerLabel?.text = row == 0 ? "DESCENDING" : "ASCENDING"
            return pickerLabel!
        }
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch component {
        case 0:
            typeOfFilter = TypeOfFilter.allCases[row]
            delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
        default:
            isAscending = row != 0
            delegate?.sorting(typeOfFilter: typeOfFilter, ascending: isAscending)
        }
    }
}

