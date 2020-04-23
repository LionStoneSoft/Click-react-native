//
//  ClickDataView.swift
//  Click.
//
//  Created by Ryan Soanes on 19/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit
import CoreData

class ClickDataView: UIViewController
 {
    @IBOutlet var clickDataTestLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChart!
    
    var clickDataArray = [NSManagedObject]()
    var dateArray = [String]()
    var dailyButtonCounter = [String:Int]()
    var buttonID: String? = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        clickDataTestLabel.text = buttonID
        populateDataArray()
        print(dateArray)
        let dataEntries = populateDataIntoChart()
        lineChart.dataEntries = dataEntries
        lineChart.isCurved = true
        lineChart.showDots = true
        lineChart.animateDots = true
        //print(dataEntries)
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
    
    private func populateDataIntoChart() -> [PointEntry] {
        var result: [PointEntry] = []
        for item in dailyButtonCounter {
            result.append(PointEntry(label: item.key, value: item.value))
        }
        return result
    }
    

    
}
