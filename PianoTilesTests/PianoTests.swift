//
//  PianoTilesTests.swift
//  PianoTilesTests
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import XCTest
@testable import PianoTiles

class PianoTests: XCTestCase {
    var piano = Piano()
    var pianoHelper = PianoHelper()
    
    override func setUp() {
        super.setUp()
        piano = Piano(rows: 4, columns: 4, rightAnswersPerRow: 2)
        pianoHelper = PianoHelper(piano: piano)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreatingRandomBlackTilePositionsUsingNumberOfTilesPerRowConfigured(){
        let blackTilePositions = pianoHelper.blackTilePositions
        XCTAssertEqual(blackTilePositions.count, piano.blackTilesPerRow)
    }
    
    func testRandomTilePositionForRow(){
        let result = pianoHelper.randomPositionInRow()
        XCTAssertLessThanOrEqual(result, piano.configuration.columns)
    }
    
    func testGetCorrectSizeForTiles(){
        let size = pianoHelper.sizeForTiles()
        XCTAssertEqual(size.width, (UIApplication.shared.keyWindow?.bounds.width)! / CGFloat(piano.configuration.columns))
        XCTAssertEqual(size.height, ((UIApplication.shared.keyWindow?.bounds.height)! / CGFloat(piano.configuration.rows) + 50))

    }
}
