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
        verticalCardSwitcher.display()
    }
    
    func numberOfCards(for verticalCardSwitcher: VerticalCardSwitcher) -> Int {
        return 120
    }
    
    func distanceBetweenCards(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
        return 20.0
    }
    
    func heightForCardView(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
        return 430.0
    }
    
    func sideMargins(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
        return 40.0
    }
    
    func addDesign(for cardView: CardView, at index: Int, in verticalCardSwitcher: VerticalCardSwitcher) {
        cardView.backgroundColor = UIColor.random()
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
        setupLabel(for: cardView, with: String(index))
    }
    
    // value from 0 to 1
    func heightOfShowedPartForEveryNextCard(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
        return 0.20
    }
    
    func currentCardScrolledDown(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
        print("currentCardScrolledDown")
    }
    
    func nextCardScrolledUp(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
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

