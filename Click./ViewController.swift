//
//  ViewController.swift
//  Click.
//
//  Created by Ryan Soanes on 15/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var clickCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        clickCollection.delegate = self
        clickCollection.dataSource = self
        clickCollection.register(UINib(nibName: "CollectionClickCell", bundle: nil), forCellWithReuseIdentifier: "collectionClickCell")

    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionClickCell", for: indexPath as IndexPath) as! CollectionClickCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
}

