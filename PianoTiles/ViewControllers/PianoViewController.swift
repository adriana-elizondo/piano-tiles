//
//  PianoViewController.swift
//  PianoTiles
//
//  Created by Adriana Elizondo Aguayo on 3/14/17.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

class PianoViewController : UIViewController {
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.scrollsToTop = false
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!{
        didSet{
            scoreView.layer.cornerRadius = 5.0
            scoreView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var failView: UIView!{
        didSet{
            failView.layer.cornerRadius = 8.0
            failView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var failViewConstraint: NSLayoutConstraint!
    
    internal var gameStyle : GameStyle
    internal var pianoHelper : PianoHelper
    internal var gameHelper : GameHelper
    fileprivate var uiHelper : UIHelper
    fileprivate var timer = Timer()
    
    init(with pianoHelper: PianoHelper) {
        self.pianoHelper = pianoHelper
        self.gameHelper = GameHelper(pianoHelper: pianoHelper)
        self.uiHelper = UIHelper()
        self.gameStyle = .Classic
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(){
        self.init(with: PianoHelper())
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.pianoHelper = PianoHelper(piano: Piano(rows: 6, columns: 4, rightAnswersPerRow: 1))
        self.gameHelper = GameHelper(pianoHelper: pianoHelper)
        self.uiHelper = UIHelper()
        self.gameStyle = .Classic
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Error view hidden by default
        failViewConstraint.constant = 700
        
        if gameStyle == .Timer{
            startTimer()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let indexPath = IndexPath(row: 0, section: (collectionView.numberOfSections - 1))
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
    }
    
    //MARK: Actions
    private func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.gameHelper.play(completion: { (userDidntMessUp) in
                self.moveFinished(userDidntMessUp, indexPath: nil)
            })
        })
    }
    
    internal func tapOnTile(with indexPath: IndexPath){
        gameHelper.play(with: indexPath) { (userDidntMessUp) in
            self.moveFinished(userDidntMessUp, indexPath: indexPath)
        }
    }
    
    private func moveFinished(_ userDidntMessUp: Bool, indexPath: IndexPath?){
        self.collectionView.isUserInteractionEnabled = true
        if userDidntMessUp == true {
            self.scoreLabel.text = "\(self.gameHelper.currentScore())"
            self.collectionView.reloadData()
        }else{
            if indexPath != nil,
                let cell = self.collectionView.cellForItem(at: indexPath!) as? TileCollectionViewCell{
                cell.errorAnimation()
            }
            
            self.animateErrorView(hide: false)
        }
    }
    
    private func animateErrorView(hide: Bool){
        self.failViewConstraint.constant = hide ? 700 : 0
        
        if hide == true && gameStyle == .Timer{
            startTimer()
        }else{
            timer.invalidate()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func retry(_ sender: Any) {
        animateErrorView(hide: true)
        self.scoreLabel.text = "\(self.gameHelper.currentScore())"
        self.collectionView.reloadData()
    }
    
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PianoViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pianoHelper.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pianoHelper.numberOfColumns()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tileCell", for: indexPath) as? TileCollectionViewCell{
            cell.backgroundColor = pianoHelper.isTileBlack(at: indexPath) ? pianoHelper.color(for: indexPath) : UIColor.white
            cell.startLabel.isHidden = !gameHelper.shouldShowStartButton(for: indexPath) || gameStyle == .Timer
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return pianoHelper.sizeForTiles()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == (pianoHelper.numberOfRows() - 1) else {return}
        tapOnTile(with: indexPath)
        self.collectionView.isUserInteractionEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}
