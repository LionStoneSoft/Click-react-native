//
//  ViewController.swift
//  Click.
//
//  Created by Ryan Soanes on 15/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {
    
    var buttonObjectsArray = [NSManagedObject]()
    var buttonObject: NSManagedObject?
    var clickCellName: String?
    var uuid: String?

    @IBOutlet var clickCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickCollection.delegate = self
        clickCollection.dataSource = self
        clickCollection.register(UINib(nibName: "CollectionClickCell", bundle: nil), forCellWithReuseIdentifier: "collectionClickCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateButtonArray()
    }
    
    func populateButtonArray() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ClickerButton")
        buttonObjectsArray.removeAll()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
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
            self.saveData()
            self.populateButtonArray()
            }
        
        ac.addAction(submitAction)
        present(ac, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return buttonObjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionClickCell", for: indexPath as IndexPath) as! CollectionClickCell
        //cell.titleLabel.text = locationObjectsArray[indexPath.row].value(forKey: "locationName") as? String
        cell.cellNameLabel.text = buttonObjectsArray[indexPath.row].value(forKey: "name") as? String
        cell.cellID = buttonObjectsArray[indexPath.row].value(forKey: "buttonID") as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        print(buttonObjectsArray[indexPath.row].value(forKey: "buttonID") as? String)
       
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
    
    func saveData() {
            //refer to AppDelegate core data container
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            //create context for container
            let managedContext = appDelegate.persistentContainer.viewContext
            //create an entity for new records
            let itemEntity = NSEntityDescription.entity(forEntityName: "ClickerButton", in: managedContext)!
            let item = NSManagedObject(entity: itemEntity, insertInto: managedContext)
            item.setValue(clickCellName, forKey: "name")
        item.setValue(uuid, forKey: "buttonID")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not save. \(error), \(error.userInfo)")
            }
        
        }
    
}

