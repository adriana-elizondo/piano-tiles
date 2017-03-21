//
//  Piano.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation

typealias PianoDesign = (rows: Int, columns: Int)

class Piano {
    var configuration : PianoDesign
    var blackTilesPerRow : Int
    
    
    init(rows: Int, columns:Int, rightAnswersPerRow: Int){
        configuration = (rows, columns)
        blackTilesPerRow = rightAnswersPerRow
    }
    
    convenience init(rows: Int, columns:Int){
        self.init(rows: rows, columns: columns, rightAnswersPerRow: 1)
        
    }
    
    convenience init(){
        self.init(rows: 4, columns: 4, rightAnswersPerRow: 1)
    }
    
}
