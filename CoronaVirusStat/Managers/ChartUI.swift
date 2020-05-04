//
//  ChartUI.swift
//  CoronaVirusStat
//
//  Created by Денис Щиголев on 14.04.2020.
//  Copyright © 2020 jedi-tones. All rights reserved.
//

import Foundation
import Charts

class ChartUI {
    
    static let shared = ChartUI()
    
    private var axisFormatDelegate: IAxisValueFormatter?
    
    func setLineChartUI(chartView: LineChartView){
        axisFormatDelegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
      
        let mark = MarkerView()
        mark.chartView = chartView
        
        chartView.drawMarkers = true
        chartView.marker = mark
        chartView.rightAxis.enabled = false
        
        chartView.leftAxis.enabled = false
        chartView.leftAxis.labelFont = UIFont(name: "Helvetica neue", size: 8)!
        chartView.leftAxis.labelCount = 10
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaxLabels = 10
        
        chartView.xAxis.enabled = true
        chartView.xAxis.labelRotationAngle = -90
        chartView.xAxis.labelFont = UIFont(name: "Helvetica neue", size: 8)!
        chartView.xAxis.drawAxisLineEnabled = true
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        
        chartView.xAxis.valueFormatter = axisFormatDelegate
        
        // chartView.xAxis.gridLineWidth = 20
        chartView.xAxis.labelCount = 25
        //chartView.xAxis.axisMaxLabels = 100
        
        let l = chartView.legend
        
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.drawInside = true
        //l.yOffset = 0
        
        chartView.highlightPerTapEnabled = true
        chartView.rightAxis.enabled = false
        
        //chartView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setPieChartUI(chartView: PieChartView) {
        
     //   chartView.holeColor = .white
       // chartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0.43)
      //  chartView.holeRadiusPercent = 0.58
       
        chartView.spin(duration: 2,
                       fromAngle: chartView.rotationAngle,
                       toAngle: chartView.rotationAngle + 360,
                       easingOption: .easeInCubic)
        
        chartView.highlightPerTapEnabled = true
        
        chartView.legend.enabled = false
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        // entry label styling
        chartView.entryLabelColor = .white
        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
    }
    
    func SetPieChartDataSet(pieChartDataSet: PieChartDataSet) {
        
        
        
    }
    
    func setLineChartDataSet(lineChartDataSet: LineChartDataSet) {
        
        switch lineChartDataSet.label {
        case DifferenceTimeSeries.confirmed.rawValue:
            lineChartDataSet.colors = [#colorLiteral(red: 0.1459183693, green: 0.1922611594, blue: 0.3337301016, alpha: 1)]
            lineChartDataSet.circleColors = [#colorLiteral(red: 0.1459183693, green: 0.1922611594, blue: 0.3337301016, alpha: 1)]
            lineChartDataSet.fillColor = #colorLiteral(red: 0.1459183693, green: 0.1922611594, blue: 0.3337301016, alpha: 1)
        case DifferenceTimeSeries.death.rawValue:
            lineChartDataSet.colors = [#colorLiteral(red: 0.8346312642, green: 0.5086384416, blue: 0.450792253, alpha: 1)]
            lineChartDataSet.circleColors = [#colorLiteral(red: 0.8346312642, green: 0.5086384416, blue: 0.450792253, alpha: 1)]
            lineChartDataSet.fillColor = #colorLiteral(red: 0.8346312642, green: 0.5086384416, blue: 0.450792253, alpha: 1)
        default:
            lineChartDataSet.colors = [#colorLiteral(red: 0.5001311302, green: 0.8252137303, blue: 0.5933588147, alpha: 1)]
            lineChartDataSet.circleColors = [#colorLiteral(red: 0.5001311302, green: 0.8252137303, blue: 0.5933588147, alpha: 1)]
            lineChartDataSet.fillColor = #colorLiteral(red: 0.5001311302, green: 0.8252137303, blue: 0.5933588147, alpha: 1)
        }
       
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode = .linear
        lineChartDataSet.drawFilledEnabled = true
        
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.highlightEnabled = true
        
    }
    
}

extension ChartUI: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/M/dd"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
        
    }
}

