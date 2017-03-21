//
//  ViewControllerTests.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import XCTest

@testable import PianoTiles

class ViewControllerTests: XCTestCase {
    var pianoViewController = PianoViewController()
    var gameHelper = GameHelper()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        pianoViewController = storyboard.instantiateViewController(withIdentifier: "PianoViewController") as! PianoViewController
        UIApplication.shared.keyWindow?.rootViewController = pianoViewController
        
        let _ = pianoViewController.view
        // Put setup code here. This method is ccalled before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoveUpOnTapCorrectAnswer(){
        let currentBlackTilesPositions = pianoViewController.pianoHelper.blackTilePositions
        let indexPath = IndexPath(row: currentBlackTilesPositions[0][2], section: 2)
        let isTileBlack = pianoViewController.pianoHelper.isTileBlack(at: indexPath)
        
        pianoViewController.tapOnTile(with: indexPath)
        let result = pianoViewController.pianoHelper.blackTilePositions
        
        if isTileBlack{
            for (index, array) in result.enumerated() {
                for position in 1..<array.count{
                    XCTAssertEqual(array[position], currentBlackTilesPositions[index][position - 1], "Different at array number \(index) in position \(position)")
                }
            }
        }else{
            for (index, _) in currentBlackTilesPositions.enumerated(){
                XCTAssertEqual(currentBlackTilesPositions[index], result[index])
            }
        }
    }
    
    func testIncreaseScoreWhenTappingRightAnswer(){
        let score = gameHelper.currentScore()
        let currentBlackTilesPositions = pianoViewController.pianoHelper.blackTilePositions
        let indexPath = IndexPath(row: currentBlackTilesPositions[0][2], section: 2)
        
        gameHelper.play(with: indexPath) { (userDidntMessUp) in
            if userDidntMessUp == true {
                XCTAssertLessThan(score, self.gameHelper.currentScore())
            }else{
                XCTAssertEqual(score, self.gameHelper.currentScore())
            }
        }
    }
    
    func testAdvanceIfCorrectOtherwiseFail(){
        let indexPath = IndexPath(row: 3, section: 2)
        pianoViewController.tapOnTile(with: indexPath)
        
    }
}
