//
//  BriefTableViewCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 09.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class BriefTableViewCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet var confirmed: UILabel!
    @IBOutlet var death: UILabel!
    @IBOutlet var recovered: UILabel!
    @IBOutlet var lineChartView: LineChartView!
    
    @IBOutlet var markerView: UIView!
    @IBOutlet var dataMarker: UILabel!
    @IBOutlet var dateMarker: UILabel!
    
    
    let realm = try! Realm()
    static let reuseID = "BriefCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setChartUI(){
        lineChartView.delegate = self
        ChartUI.shared.setLineChartUI(chartView: lineChartView)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        markerView.isHidden = false

        dataMarker.text = "\(Int(highlight.y))"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/M/dd"
        dateMarker.text = "\(dateFormatter.string(from: Date(timeIntervalSince1970: highlight.x)))"
        
        markerView.center = CGPoint(x: highlight.xPx - 30, y: highlight.yPx - 10)
    }
    
    func setLineChartData(){
        
        guard let results = realm.objects(BriefRealm.self).first?.timesSeries else { return }
        var dataConfirmed: [ChartDataEntry] = []
        var dataDeath: [ChartDataEntry] = []
        var dataRecovered: [ChartDataEntry] = []
        
        for date in results {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy/M/dd"
            guard let currentDate = dateFormatter.date(from: date.date) else { return }
            
            let timeInterval: TimeInterval = currentDate.timeIntervalSince1970
            
            let chartDataConfrmed = ChartDataEntry(x: Double(timeInterval), y: Double(date.confirmed))
            let chartDataDeath = ChartDataEntry(x: Double(timeInterval), y: Double(date.deaths))
            let chartDataRecovered = ChartDataEntry(x: Double(timeInterval), y: Double(date.recovered))
            
            dataConfirmed.append(chartDataConfrmed)
            dataDeath.append(chartDataDeath)
            dataRecovered.append(chartDataRecovered)
            
        }
        
        let lineChartDataSetConfirmed = LineChartDataSet(entries: dataConfirmed, label: DifferenceTimeSeries.confirmed.rawValue)
        let lineChartDataSetDeath = LineChartDataSet(entries: dataDeath, label: DifferenceTimeSeries.death.rawValue)
        let lineChartDataSetRecovered = LineChartDataSet(entries: dataRecovered, label: DifferenceTimeSeries.recovered.rawValue)
        
        ChartUI.shared.setLineChartDataSet(lineChartDataSet: lineChartDataSetConfirmed)
        ChartUI.shared.setLineChartDataSet(lineChartDataSet: lineChartDataSetDeath)
        ChartUI.shared.setLineChartDataSet(lineChartDataSet: lineChartDataSetRecovered)
        
        let chartData = LineChartData()
        chartData.addDataSet(lineChartDataSetConfirmed)
        chartData.addDataSet(lineChartDataSetDeath)
        chartData.addDataSet(lineChartDataSetRecovered)
        
        lineChartView.data = chartData
        
    }
    
    
    func setCell(){
        confirmed.text = "\(realm.objects(BriefRealm.self).first?.confirmed ?? 0)"
        death.text = "\(realm.objects(BriefRealm.self).first?.death ?? 0)"
        recovered.text = "\(realm.objects(BriefRealm.self).first?.recovered ?? 0)"
        
    }
}



