//
//  LineChartBriefCell.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 06.05.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class LineChartBriefCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet var lineChart: LineChartView!
    @IBOutlet var infoView: UIView!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    
    let realm = try! Realm()
    static let reuseID = "LineChartBriefCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setChartUI() {
        lineChart.chartDescription?.text = "Time series" 
        lineChart.delegate = self
        
        infoView.backgroundColor = .init(white: 1, alpha: 0)
        ChartUI.shared.setLineChartUI(chartView: lineChart)
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        infoView.isHidden = false
        
        dataLabel.text = highlight.y.formattedWithSeparator
        let offSetX = CGFloat(40)
        let offSetY = CGFloat(14)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        datelabel.text = "\(dateFormatter.string(from: Date(timeIntervalSince1970: highlight.x)))"
        
        infoView.center = CGPoint(x: highlight.xPx - offSetX, y: highlight.yPx - offSetY)
    }
    
    
    func setChartData(typeOfData: TypeOfChartData, realmData: VirusRealm?){
        
        var results: List<TimeseryRealm>?
        switch typeOfData {
        case TypeOfChartData.brief:
            guard let resultsRealm = realm.objects(BriefRealm.self).first?.timesSeries else { return }
            results = resultsRealm
        default:
            guard let resultsRealm = realmData?.timeSeries else { return }
            results = resultsRealm
        }
        
        var dataConfirmed: [ChartDataEntry] = []
        var dataDeath: [ChartDataEntry] = []
        var dataRecovered: [ChartDataEntry] = []
        
        for date in results!.sorted(byKeyPath: "date", ascending: true) {
            
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
        
        lineChart.data = chartData
        
    }
    
}
