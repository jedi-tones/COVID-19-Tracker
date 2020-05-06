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
    
    func setChartData() {
        guard let results  = realm.objects(BriefRealm.self).first else { return }
        var pieChartEntries: [PieChartDataEntry] = []
        
        let currentSick = results.confirmed - results.death - results.recovered
        
        let pieChartSickEntry = PieChartDataEntry(value: Double(currentSick), label: "Sick")
        let pieChartDeathEntry = PieChartDataEntry(value: Double(results.death), label: "Death")
        let pieChartRecoveredEntry = PieChartDataEntry(value: Double(results.recovered), label: "Recovered")
        
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
        pFormatter.percentSymbol = " %"
        
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.white)
        
        pieChart.data = data
        pieChart.highlightValues(nil)
    }
    
}
