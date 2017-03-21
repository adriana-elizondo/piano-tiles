//
//  GameHelper.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation

typealias PlayActionCompletion = (_ correctMove: Bool) -> Void

class GameHelper {
    private var score = 0
    
    var pianoHelper : PianoHelper
    
    init(pianoHelper: PianoHelper) {
        self.pianoHelper = pianoHelper
    }
    
    convenience init(){
        self.init(pianoHelper: PianoHelper())
    }
    
    internal func currentScore() -> Int{
        return score
    }
    
    internal func play(completion: @escaping PlayActionCompletion){
        pianoHelper.changeTilePosition {
            completion(true)
        }
    }
    
    internal func play(with indexPath: IndexPath, completion: @escaping PlayActionCompletion){
        if pianoHelper.isTileBlack(at: indexPath) == true {
            pianoHelper.changeTilePosition {
                self.score += 1
                completion(true)
            }
        }else{
            self.score = 0
            completion(false)
        }
    }
    
    internal func shouldShowStartButton(for indexPath: IndexPath) -> Bool{
        guard pianoHelper.blackTilePositions[0].count > 0 else {return false}
        return (indexPath.section == (pianoHelper.numberOfRows() - 1) && score == 0) && pianoHelper.isTileBlack(at: indexPath)
    }
    
}
