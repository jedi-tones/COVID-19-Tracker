//
//  PieChartBriefCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 06.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift
import Charts


class PieChartBriefCell: UITableViewCell {
    
    let realm = try! Realm()
    static let reuseID = "PieChartBriefCell"
    
    @IBOutlet var pieChart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChartUI() {
        ChartUI.shared.setPieChartUI(chartView: pieChart)
    }
    
    func setChartData(typeOfData: TypeOfChartData, realmData: VirusRealm?) {
        
        var confirmed = 0
        var death = 0
        var recovered = 0
        
        switch typeOfData {
        case TypeOfChartData.brief:
            guard let results  = realm.objects(BriefRealm.self).first else { return }
            confirmed = results.confirmed
            death = results.death
            recovered = results.recovered
        default:
            guard let results = realmData else { return }
            confirmed = results.confirmed
            death = results.deaths
            recovered = results.recovered
        }
        
        var pieChartEntries: [PieChartDataEntry] = []
        
        let currentSick = confirmed - death - recovered
        
        let pieChartSickEntry = PieChartDataEntry(value: Double(currentSick), label: "SICK")
        let pieChartDeathEntry = PieChartDataEntry(value: Double(death), label: "DEATH")
        let pieChartRecoveredEntry = PieChartDataEntry(value: Double(recovered), label: "RECOVERED")
        
        pieChartEntries.append(pieChartSickEntry)
        pieChartEntries.append(pieChartDeathEntry)
        pieChartEntries.append(pieChartRecoveredEntry)
        
        let dataSet = PieChartDataSet(entries: pieChartEntries, label: "")
        
        ChartUI.shared.SetPieChartDataSet(pieChartDataSet: dataSet)
        
        let data = PieChartData(dataSet: dataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .medium))
        data.setValueTextColor(.label)
        
        pieChart.data = data
        pieChart.highlightValues(nil)
    }
    
    
    
}
