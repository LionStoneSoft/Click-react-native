//
//  ClickDataView.swift
//  Click.
//
//  Created by Ryan Soanes on 19/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit
import CoreData
import Charts

class ClickDataView: UIViewController, ChartViewDelegate
 {
    @IBOutlet var clickDataTestLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!
    
    var clickDataArray = [NSManagedObject]()
    var dateArray = [String]()
    var dailyButtonCounter = [String:Int]()
    var buttonID: String? = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        clickDataTestLabel.text = buttonID
        populateDataArray()
        print(dateArray)
        lineChart.backgroundColor = .systemTeal
        lineChart.rightAxis.enabled = false
        let yAxis = lineChart.leftAxis
        let xAxis = lineChart.xAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        xAxis.labelPosition = .bottom
        xAxis.axisLineColor = .white
        xAxis.labelTextColor = .white
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        
        lineChart.animate(yAxisDuration: 1, easingOption: .easeOutSine)
        
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //print(entry)
        print("ppap")

    }
    
    func populateDataArray() {
        
//    let today = Date()
//    let formatter3 = DateFormatter()
//    formatter3.dateFormat = "HH:mm \nd MMM y"
//    //print(formatter3.string(from: today))
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButtonData")
        fetchRequest.predicate = NSPredicate(format: "buttonID = %@", buttonID!)
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [ClickerButtonData]
        for object in resultData {
            
            let today = object.date
            let formatter3 = DateFormatter()
//            formatter3.dateFormat = "HH:mm \nd MMM y"
            formatter3.dateFormat = "d MMM"
            //print(formatter3.string(from: today))
            
            let dateString = formatter3.string(from: today!)
            
            //let dateString = String(object.date)
            clickDataArray = clickDataArray +  [object]
            dateArray = dateArray + [dateString]
            
            let mappedItems = dateArray.map { ($0, 1) }
            let counts = Dictionary(mappedItems, uniquingKeysWith: +)
            dailyButtonCounter = counts
            
        }
        //clickCollection.reloadData()
        print(clickDataArray.count)
        print(dailyButtonCounter)
    }
    
//    private func generateRandomEntries() -> [PointEntry] {
//        var result: [PointEntry] = []
//        for i in 0..<100 {
//            let value = Int(arc4random() % 500)
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "d MMM"
//            var date = Date()
//            date.addTimeInterval(TimeInterval(24*60*60*i))
//
//            result.append(PointEntry(label: formatter.string(from: date), value: value))
//        }
//        return result
//    }
    
//    private func populateDataIntoChart() -> [PointEntry] {
//        var result: [PointEntry] = []
//        result.append(PointEntry(label: "21 Apr", value: 1))
//        for item in dailyButtonCounter {
//            result.append(PointEntry(label: item.key, value: item.value))
//        }
//        return result
//    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues, label: "Week")
        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.white)
        
//        fills in the lower portion of line
        
//        set1.fill = Fill(color: .white)
//        set1.fillAlpha = 0.8
//        set1.drawFilledEnabled = true
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .red
        set1.highlightLineWidth = 2
        
        let data = LineChartData(dataSet: set1)
        
        data.setDrawValues(false)
        lineChart.data = data
    }
    
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 1.0),
        ChartDataEntry(x: 1.0, y: 3.0),
        ChartDataEntry(x: 2.0, y: 6.0),
        ChartDataEntry(x: 3.0, y: 2.0),
        ChartDataEntry(x: 4.0, y: 3.0),
        ChartDataEntry(x: 5.0, y: 1.0),
        ChartDataEntry(x: 6.0, y: 11.0)
    ]

    
}
