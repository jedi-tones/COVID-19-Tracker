//
//  BriefTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 09.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class BriefTableViewCell: UITableViewCell {

    @IBOutlet var backView: UIView!
    
    static let reuseID = "BriefCell"
    override func awakeFromNib() {
        super.awakeFromNib()
       // setUI()
    }
    
    

     func setUI(){
        backView.layer.cornerRadius = 5
        
        
        
    }
    
    
}
