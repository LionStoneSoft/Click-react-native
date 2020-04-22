//
//  CollectionClickCell.swift
//  Click.
//
//  Created by Ryan Soanes on 16/02/2020.
//  Copyright © 2020 LionStone. All rights reserved.
//

import UIKit

class CollectionClickCell: UICollectionViewCell {

    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var cellNameLabel: UILabel!
    @IBOutlet var cellLastDateAndTime: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var cellButtonCountLabel: UILabel!
    var cellID: String?
    var pressCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedImage()

        // Initialization code
    }
        
    func roundedImage() {
        self.backgroundImage.layer.cornerRadius = 25
        self.backgroundImage.clipsToBounds = true
    }

    override var isHighlighted: Bool {
        didSet {
            toggleIsHighlighted()
        }
    }
    
    func toggleIsHighlighted() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
            self.alpha = self.isHighlighted ? 0.9 : 1.0
            self.transform = self.isHighlighted ?
                CGAffineTransform.identity.scaledBy(x: 0.90, y: 0.90) :
                CGAffineTransform.identity
        })
    }
}
