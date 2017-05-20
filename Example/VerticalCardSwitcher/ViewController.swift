//
//  ViewController.swift
//  VerticalCardSwitcher
//
//  Created by kruljac.matija@gmail.com on 05/19/2017.
//  Copyright (c) 2017 kruljac.matija@gmail.com. All rights reserved.
//

import UIKit
import VerticalCardSwitcher

class ViewController: UIViewController, VerticalCardSwitcherDelegate {
    
    var verticalCardSwitcher: VerticalCardSwitcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalCardSwitcher = VerticalCardSwitcher.init(in: view)
        verticalCardSwitcher.delegate = self
        verticalCardSwitcher.setupMarginsAndInitialFrames(top: 100, sides: 30)
        verticalCardSwitcher.display()
    }
    
    func numberOfCards() -> Int {
        return 120
    }
    
    func distanceBetweenCards() -> CGFloat {
        return 20.0
    }
    
    func design(for cardView: CardView, at index: Int) {
        cardView.backgroundColor = UIColor.random()
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
        setupLabel(for: cardView, with: String(index))
    }
    
    func nextCardStartedScrollingUp(cardView: CardView) {
        print("nextCardStartedScrollingUp")
    }
    
    func currentCardStartedScrollingDown(cardView: CardView) {
        print("currentCardStartedScrollingDown")
    }
    
    func currentCardScrolledDown(cardView: CardView) {
        print("currentCardScrolledDown")
    }
    
    func nextCardScrolledUp(cardView: CardView) {
        print("nextCardScrolledUp")
    }
    
    private func setupLabel(for cardView: CardView, with text: String) {
        let frame = CGRect(
            x: cardView.frame.size.width/2 - 50,
            y: cardView.frame.size.height/2 - 50,
            width: 100,
            height: 100)
        let label = UILabel(frame: frame)
        label.text = text
        label.backgroundColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.frame.width/2
        cardView.addSubview(label)
        cardView.bringSubview(toFront: label)
    }
}

