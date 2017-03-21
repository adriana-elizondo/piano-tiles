//
//  Tile.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class Tile {
    internal var position : Int
    internal var color : UIColor
    
    init(position: Int, color: UIColor) {
        self.position = position
        self.color = color
    }
}
