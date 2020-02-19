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
    var buttonID: String? = "testetstesteste"

    override func viewDidLoad() {
        super.viewDidLoad()
        clickDataTestLabel.text = buttonID
    }
}
