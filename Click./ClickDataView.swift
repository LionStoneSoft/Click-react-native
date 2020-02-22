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
    var clickDataArray = [NSManagedObject]()
    var buttonID: String? = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        clickDataTestLabel.text = buttonID
        populateDataArray()
    }
    
    func populateDataArray() {
        
//        let today = Date()
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = "HH:mm \nd MMM y"
        //print(formatter3.string(from: today))
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButtonData")
        fetchRequest.predicate = NSPredicate(format: "buttonID = %@", buttonID!)
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [ClickerButtonData]
        for object in resultData {
            clickDataArray = clickDataArray +  [object]
        }
        //clickCollection.reloadData()
        print(clickDataArray.count)
    }
    
//        func populateClickDataArray() {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//            let managedContext = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButtonData")
//            clickDataArray.removeAll()
//            do {
//                let result = try managedContext.fetch(fetchRequest)
//                for data in result as! [NSManagedObject] {
//    //                print(data.value(forKey: "buttonID") as! String)
//    //                print(data.value(forKey: "date") as! Date)
//                    //print(clickDataArray.count)
//                    clickDataArray = clickDataArray + [data]
//                }
//                clickCollection.reloadData()
//            } catch {
//                print("failed homie")
//            }
//        }
}
