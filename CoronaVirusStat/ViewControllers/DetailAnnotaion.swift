//
//  DetailAnnotaion.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 11.06.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit

class DetailAnnotaion: UIView {
    
    @IBOutlet var textAnnotation: UILabel!
    
    var textLabelText: String {
        get {
            textAnnotation.text!
        }
        set(newText) {
            textAnnotation.text = newText
        }
    }
    
    var nibName = "DetailAnnotation"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    
     func loadNib() -> UIView {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
    }

    func setUI(){
        let view = loadNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(view)
    }
}
