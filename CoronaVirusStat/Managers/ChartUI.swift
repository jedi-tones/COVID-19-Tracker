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
    
    //MARK: - LineChartUI
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
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8)!
        chartView.leftAxis.labelTextColor = .label
        chartView.leftAxis.labelCount = 10
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaxLabels = 10
        
        chartView.rightAxis.enabled = false
        chartView.rightAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8)!
        chartView.rightAxis.labelCount = 6
        chartView.rightAxis.drawAxisLineEnabled = true
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.rightAxis.axisMinimum = 0
        chartView.rightAxis.axisMaxLabels = 10
        chartView.rightAxis.valueFormatter = axisFormatDelegate
        
         
        chartView.xAxis.enabled = true
        chartView.xAxis.labelCount = 7
        chartView.xAxis.axisMaxLabels = 7
        //chartView.xAxis.labelRotationAngle = -90
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8)!
        chartView.xAxis.labelTextColor = .label
        chartView.xAxis.drawAxisLineEnabled = true
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        
        
        chartView.xAxis.valueFormatter = axisFormatDelegate
        
        // chartView.xAxis.gridLineWidth = 20
        chartView.xAxis.labelCount = 25
        //chartView.xAxis.axisMaxLabels = 100
        
        let l = chartView.legend
        
        l.font = UIFont(name: "HelveticaNeue-Light", size: 8)!
        l.textColor = .label
        l.horizontalAlignment = .left
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.drawInside = true
        //l.yOffset = 0
        
        chartView.highlightPerTapEnabled = true
       
        
        //chartView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    //MARK: - PieChartsUI
    func setPieChartUI(chartView: PieChartView) {
        
        chartView.holeColor = .init(white: 1, alpha: 0)
        // chartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0.43)
        // chartView.holeRadiusPercent = 0.58
        //chartView.backgroundColor = .blue
       // chartView.drawHoleEnabled = false
        chartView.extraBottomOffset = 50
        chartView.extraTopOffset = 170
        
        chartView.usePercentValuesEnabled = true
        chartView.maxAngle = 180
        chartView.rotationAngle = 180
        chartView.rotationEnabled = false
        chartView.drawEntryLabelsEnabled = false
        //chartView.animate(xAxisDuration: 2)
        
        chartView.highlightPerTapEnabled = false
        
        chartView.legend.enabled = true
        
        let l = chartView.legend
        l.font = UIFont(name: "HelveticaNeue-Light", size: 8)!
        l.textColor = .label
        l.horizontalAlignment = .left
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset =  -170
        
        // entry label styling
         chartView.entryLabelColor = .label
  
        
    }
    
    //MARK: - PieChartsDataSet
    func SetPieChartDataSet(pieChartDataSet: PieChartDataSet) {
        
        pieChartDataSet.colors = [#colorLiteral(red: 0.1459183693, green: 0.1922611594, blue: 0.3337301016, alpha: 1),#colorLiteral(red: 0.8346312642, green: 0.5086384416, blue: 0.450792253, alpha: 1),#colorLiteral(red: 0.5001311302, green: 0.8252137303, blue: 0.5933588147, alpha: 1)]
        
        pieChartDataSet.sliceSpace = 2
        
        pieChartDataSet.yValuePosition = .outsideSlice
        pieChartDataSet.xValuePosition = .outsideSlice
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
        pieChartDataSet.valueLinePart1Length = 0.3
        pieChartDataSet.valueLinePart2Length = 0.2
        pieChartDataSet.valueLineColor = .label
        pieChartDataSet.entryLabelColor = .label
        
        
       
        
    }
    
    //MARK: - LineChartsDataSet
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

//MARK: - AxisValueFormatter
extension ChartUI: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if axis?.isKind(of: XAxis.self) ?? false {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            return dateFormatter.string(from: Date(timeIntervalSince1970: value))
        } else
        {
            return value.formattedWithSeparator
        }
    }
}

