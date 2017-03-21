//
//  MenuViewController.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/21/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

enum GameStyle{
    case Classic, Timer
}

final class MenuViewController : UIViewController{
    private var gameStyle : GameStyle = .Classic
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PianoViewController{
            controller.gameStyle = gameStyle
        }
    }
    
    private func segue(with style: GameStyle){
        gameStyle = style
        self.performSegue(withIdentifier: "play", sender: self)
    }
    
    @IBAction func playWithTimer(_ sender: Any) {
        segue(with: .Timer)
    }
    
    
    @IBAction func playWithoutTimer(_ sender: Any) {
        segue(with: .Classic)
    }
}
