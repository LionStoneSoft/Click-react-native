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
    var dateArray = [String]()
    var buttonID: String? = "test"

    override func viewDidLoad() {
        super.viewDidLoad()
        clickDataTestLabel.text = buttonID
        populateDataArray()
        print(dateArray)
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
            formatter3.dateFormat = "HH:mm"
            //print(formatter3.string(from: today))
            
            let dateString = formatter3.string(from: today!)
            
            //let dateString = String(object.date)
            clickDataArray = clickDataArray +  [object]
            dateArray = dateArray + [dateString]
        }
        //clickCollection.reloadData()
        print(clickDataArray.count)
    }
    

    
}
