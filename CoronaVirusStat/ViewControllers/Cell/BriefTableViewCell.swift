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

class BriefTableViewCell: UITableViewCell {
    
    @IBOutlet var confirmed: UILabel!
    @IBOutlet var death: UILabel!
    @IBOutlet var recovered: UILabel!
    @IBOutlet var lineChartView: LineChartView!
    private var axisFormatDelegate: IAxisValueFormatter?
    
    
    let realm = try! Realm()
    static let reuseID = "BriefCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        axisFormatDelegate = self
    }
    
    
    
    func setUI(){
        lineChartView.rightAxis.enabled = false
        
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
        let chartData = LineChartData()
        chartData.addDataSet(lineChartDataSet)
        
        lineChartView.data = chartData
    }
    
    private func getBriefTimeSeriesRealm() -> List<TimeseryRealm>? {
        
        guard let data = realm.objects(BriefRealm.self).first?.timesSeries else { return nil }
        return data
    }
    
    func setCell(){
        confirmed.text = "\(realm.objects(BriefRealm.self).first?.confirmed ?? 0)"
        death.text = "\(realm.objects(BriefRealm.self).first?.death ?? 0)"
        recovered.text = "\(realm.objects(BriefRealm.self).first?.recovered ?? 0)"
        
    }
    
}

extension BriefTableViewCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    
}
