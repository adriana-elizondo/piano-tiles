//
//  PianoHelper.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class PianoHelper{
    internal var piano : Piano
    internal var blackTilePositions = [[Int]]()
    internal var blackTileColors = [[UIColor]]()
    fileprivate var uiHelper = UIHelper()
    internal var tileNumber = 0
    internal var currentSection = 0
    
    init(piano : Piano) {
        self.piano = piano
        createCorrectOptions()
        createTileColors()
    }
    
    convenience init(){
        self.init(piano: Piano())
    }
    
    private func createCorrectOptions(){
        for _ in 0..<piano.blackTilesPerRow{
            let tempArray = blackTilePositionsArray()
            blackTilePositions.append(tempArray)
        }
    }
    
    private func createTileColors(){
        for _ in 0..<piano.blackTilesPerRow{
            let tempArray = randomColorArray()
            blackTileColors.append(tempArray)
        }
    }
    
    internal func numberOfRows() -> Int{
        return piano.configuration.rows
    }
    
    internal func numberOfColumns() -> Int{
        return piano.configuration.columns
    }
    
    internal func sizeForTiles() -> CGSize {
        let windowWidth = UIApplication.shared.keyWindow?.bounds.width ?? 0
        let windowHeight = UIApplication.shared.keyWindow?.bounds.height ?? 0
        
        return CGSize(width: windowWidth / CGFloat(piano.configuration.columns), height: (windowHeight / CGFloat(piano.configuration.rows)) + 50)
    }
    
    private func blackTilePositionsArray() -> [Int]{
        var positionArray = [Int]()
        for _ in 0..<piano.blackTilesPerRow {
            for _ in 0..<piano.configuration.rows {
                positionArray.append(randomPositionInRow())
            }
        }
        return positionArray
    }
    
    private func randomColorArray() -> [UIColor]{
        var tempArray = [UIColor]()
        for _ in 0..<piano.blackTilesPerRow {
            for _ in 0..<piano.configuration.rows {
                tempArray.append(uiHelper.randomColor())
            }
        }
        
        return tempArray
    }
    
    internal func randomPositionInRow() -> Int {
        return Int(arc4random_uniform(UInt32(piano.configuration.columns - 1)))
    }
    
    internal func color(for indexPath: IndexPath) -> UIColor{
        guard indexPath.section == currentSection else {
            currentSection = indexPath.section
            tileNumber = 0
            return blackTileColors[tileNumber][indexPath.section]
        }
        
        guard blackTileColors.count > 1 else {
            tileNumber = 0
            let color = blackTileColors[tileNumber][indexPath.section]
            return color
        }
        
        let color = blackTileColors[tileNumber][indexPath.section]
        tileNumber += 1
        return color
    }
    
}

extension PianoHelper{
    internal func isTileBlack(at indexPath: IndexPath) -> Bool{
        for array in blackTilePositions{
            guard array.count > indexPath.section else {return false}
            
            if array[indexPath.section] == indexPath.row {
                return true
            }
        }
        
        return false
    }
    
    internal func changeTilePosition(with completion: @escaping () -> Void){
        for (index, var positionArray) in blackTilePositions.enumerated(){
            guard positionArray.count > 0 else {return}
            
            var colorArray = blackTileColors[index]
            
            var tempArray = positionArray
            var tempcolorArray = colorArray
            
            for position in 1..<positionArray.count{
                positionArray[position] = tempArray[position - 1]
                colorArray[position] = tempcolorArray[position - 1]
            }
            
            positionArray[0] = randomPositionInRow()
            colorArray[0] = uiHelper.randomColor()
            blackTilePositions[index] = positionArray
            blackTileColors[index] = colorArray
        }
        
        completion()
    }
}


