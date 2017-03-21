//
//  UIHelper.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/16/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class UIHelper{
    private var randomColors = [
        UIColor.init(colorLiteralRed: 214/255.0, green: 135/255.0, blue: 157/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 245/255.0, green: 40/255.0, blue: 135/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 255/255.0, green: 204/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 2/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0),
        UIColor.black,
        UIColor.init(colorLiteralRed: 214/255.0, green: 135/255.0, blue: 157/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 245/255.0, green: 40/255.0, blue: 135/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 255/255.0, green: 204/255.0, blue: 0/255.0, alpha: 1.0),
        UIColor.init(colorLiteralRed: 2/255.0, green: 214/255.0, blue: 214/255.0, alpha: 1.0),
        UIColor.black
    ]
    
    internal func randomColor() -> UIColor{
        let randomNumber = Int(arc4random_uniform(9))
        
        guard randomColors.count > randomNumber else {return UIColor.black}
        return randomColors[randomNumber]
    }
    
}
