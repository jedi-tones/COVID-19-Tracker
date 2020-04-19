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
        
        chartView.chartDescription?.text = "Brief time series"
        
        //  chartView.maxVisibleCount = 20
        
        let mark = MarkerView()
        
        mark.chartView = chartView
        
        
        
        let maxElement = chartView.data?.entryCount ?? 0
        // chartView.setVisibleXRangeMaximum(30)
        
        chartView.setDragOffsetX(CGFloat(maxElement))
        chartView.drawMarkers = true
        chartView.marker = mark
        chartView.rightAxis.enabled = false
        
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
        
        chartView.highlightPerTapEnabled = true
        chartView.rightAxis.enabled = false
        
        //chartView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func setLineChartDataSet(lineChartDataSet: LineChartDataSet) {
        
        lineChartDataSet.colors = [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
        lineChartDataSet.circleColors = [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.mode   = .linear
        lineChartDataSet.drawFilledEnabled = true
        lineChartDataSet.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
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

