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
                     
        print("\(highlight.xPx) \(highlight.yPx)")
        dataMarker.text = "\(Int(highlight.y))"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/M/dd"
        dateMarker.text = "\(dateFormatter.string(from: Date(timeIntervalSince1970: highlight.x)))"
        
        markerView.center = CGPoint(x: highlight.xPx - 30, y: highlight.yPx - 10)
                 }
    
    func setChartData(){
        
        
        guard let results = realm.objects(BriefRealm.self).first?.timesSeries else { return }
        var data: [ChartDataEntry] = []
        
       
        
        for date in results {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy/M/dd"
            guard let currentDate = dateFormatter.date(from: date.date) else { return }
            
            let timeInterval: TimeInterval = currentDate.timeIntervalSince1970
            
            let chartDataEntry = ChartDataEntry(x: Double(timeInterval), y: Double(date.confirmed))
            data.append(chartDataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: data, label: "Confirmed chart")
        
        ChartUI.shared.setLineChartDataSet(lineChartDataSet: lineChartDataSet)
        
        let chartData = LineChartData()
        chartData.addDataSet(lineChartDataSet)
        
        
        lineChartView.data = chartData
    
    }
    
    
    func setCell(){
        confirmed.text = "\(realm.objects(BriefRealm.self).first?.confirmed ?? 0)"
        death.text = "\(realm.objects(BriefRealm.self).first?.death ?? 0)"
        recovered.text = "\(realm.objects(BriefRealm.self).first?.recovered ?? 0)"
        
    }
}

    

