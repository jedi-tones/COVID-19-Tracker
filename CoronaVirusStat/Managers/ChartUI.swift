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
    
    func setLineChartUI(chartView: LineChartView){
        chartView.leftAxis.labelFont = UIFont(name: "Helvetica neue", size: 8)!
        chartView.leftAxis.labelCount = 10
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0
        
        
        
        chartView.xAxis.enabled = true
        chartView.xAxis.labelRotationAngle = -45
        chartView.xAxis.labelFont = UIFont(name: "Helvetica neue", size: 8)!
        chartView.xAxis.drawAxisLineEnabled = true
        chartView.xAxis.drawGridLinesEnabled = true
        
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
        //chartDataSet2.drawValuesEnabled = false
        lineChartDataSet.fillColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        lineChartDataSet.drawValuesEnabled = false
    }
    
    
    
}
