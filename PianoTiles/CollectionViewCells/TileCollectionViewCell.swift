//
//  TileCollectionViewCells.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class TileCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var startLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
    }
    
    internal func errorAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = UIColor.red
        }) { (bool) in
            UIView.animate(withDuration: 0.25, animations: { 
                self.backgroundColor = UIColor.white
            })
        }
    }
}
