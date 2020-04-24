//
//  ViewController.swift
//  Click.
//
//  Created by Ryan Soanes on 15/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate
 {
    
    var buttonObjectsArray = [NSManagedObject]()
    var clickCellName: String?
    var uuid: String? = "ppap"
    var clickDate = Date()
    var buttonCount = 0

    @IBOutlet var clickCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let today = Date()
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = "HH:mm \nd MMM y"
//        print(formatter3.string(from: today))
        
        clickCollection.delegate = self
        clickCollection.dataSource = self
        //register nib
        clickCollection.register(UINib(nibName: "CollectionClickCell", bundle: nil), forCellWithReuseIdentifier: "collectionClickCell")
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.7
        //lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.clickCollection.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state != .ended else { return }
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
        let point = gestureRecognizer.location(in: clickCollection)

        if let indexPath = clickCollection.indexPathForItem(at: point)//,
           //let cell = clickCollection.cellForItem(at: indexPath)
        {
            // do stuff with your cell, for example print the indexPath
            uuid = buttonObjectsArray[indexPath.row].value(forKey: "buttonID") as? String
            self.performSegue(withIdentifier: "goToData", sender: self)
            print(indexPath.row)
        } else {
            print("Could not find index path")
        }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //populate button grid on load
        populateButtonArray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToData" {
            let secondView = segue.destination as! ClickDataView
            secondView.buttonID = uuid
        }
    }
    
    //refreshes and re-populates array
    func populateButtonArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButton")
        buttonObjectsArray.removeAll()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "name") as! String)
//                print(data.value(forKey: "buttonID") as! String)
                buttonObjectsArray = buttonObjectsArray + [data]
            }
            clickCollection.reloadData()
        } catch {
            print("failed homie")
        }
    }
    
    @IBAction func clickAddButton(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Enter clickable name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.clickCellName = answer.text
            self.uuid = UUID().uuidString
            self.saveNewButton()
            self.populateButtonArray()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel",
        style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return buttonObjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellsCount: Int = buttonObjectsArray[indexPath.row].value(forKey: "buttonCount") as! Int
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionClickCell", for: indexPath as IndexPath) as! CollectionClickCell
        cell.cellNameLabel.text = buttonObjectsArray[indexPath.row].value(forKey: "name") as? String
        cell.cellID = buttonObjectsArray[indexPath.row].value(forKey: "buttonID") as? String
        cell.cellButtonCountLabel.text = String(cellsCount) //String(buttonCount)
        cell.cellLastDateAndTime.text = buttonObjectsArray[indexPath.row].value(forKey: "latestDate") as? String
        
        let leftSwipeGest = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade))
        leftSwipeGest.direction = .left
        cell.addGestureRecognizer(leftSwipeGest)
        
        let rightSwipeGest = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade))
        rightSwipeGest.direction = .right
        cell.addGestureRecognizer(rightSwipeGest)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
        uuid = buttonObjectsArray[indexPath.row].value(forKey: "buttonID") as? String
        clickDate = Date()
        saveClickData()
        storeButtonCount(buttonIDString: uuid!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
    func saveNewButton() {
            //refer to AppDelegate core data container
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            //create context for container
            let managedContext = appDelegate.persistentContainer.viewContext
            //create an entity for new records
            let itemEntity = NSEntityDescription.entity(forEntityName: "ClickerButton", in: managedContext)!
            let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
            item.setValue(clickCellName, forKey: "name")
        item.setValue(uuid, forKey: "buttonID")
        item.setValue(0, forKey: "buttonCount")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not save. \(error), \(error.userInfo)")
            }
        
        }
    
    func saveClickData() {
        //refer to AppDelegate core data container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        //create context for container
        let managedContext = appDelegate.persistentContainer.viewContext
        //create an entity for new records
        let itemEntity = NSEntityDescription.entity(forEntityName: "ClickerButtonData", in: managedContext)!
        let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
        item.setValue(clickDate, forKey: "date")
    item.setValue(uuid, forKey: "buttonID")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    
    }
    
    func storeButtonCount(buttonIDString: String) {
        
        let today = Date()
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm \nd MMM y"
        //print(formatter3.string(from: today))
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButton")
        fetchRequest.predicate = NSPredicate(format: "buttonID = %@", buttonIDString)
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [ClickerButton]
        for object in resultData {
            buttonCount = Int(object.buttonCount + 1)
            object.buttonCount = object.buttonCount + 1
            object.latestDate = formatter3.string(from: today)
        }
        do {
            try managedContext.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        clickCollection.reloadData()
        
    }
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
                
       if sender.direction == .left {
          print("left swipe made")
       }
       if sender.direction == .right {
          print("right swipe made")
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Default placeholder text"
        }

        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            print("User text: \(userText)")
        }))

        self.present(alert, animated: true, completion: nil)
       }
    }
    
//    func updateButtonDateAndCount() {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButton")
//
//            let request = NSFetchRequest<ClickerButton>(entityName: "ClickerButton")
//        request.predicate = NSPredicate(format: "buttonID == %@", uuid!)
//
//            let users = try self.context.fetch(request)
//            return users
//
//    }
    
}

