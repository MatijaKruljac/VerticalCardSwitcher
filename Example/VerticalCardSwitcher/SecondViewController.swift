//
//  SecondViewController.swift
//  VerticalCardSwitcher
//
//  Created by Matija Kruljac on 21/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import VerticalCardSwitcher

class SecondViewController: UIViewController, VerticalCardSwitcherDelegate {
    
    private var verticalCardSwitcher: VerticalCardSwitcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Example 2"
        view.backgroundColor = UIColor(red: 0.9176, green: 0.3647, blue: 0.3647, alpha: 1.0)
        
        verticalCardSwitcher = VerticalCardSwitcher.init(in: view)
        verticalCardSwitcher.delegate = self
        verticalCardSwitcher.display()
    }
    
    func numberOfCards(for verticalCardSwitcher: VerticalCardSwitcher) -> Int {
        return 22
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
        cardView.backgroundColor = UIColor(red: 0.2078, green: 0.4275, blue: 0.9098, alpha: 1.0)
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        addSubviews(for: cardView)
        addStarButton(for: cardView)
    }
    
    // values from 0 to 1
    func heightOfShowedPartForEveryNextCard(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat {
        return 0.20
    }
    
    func currentCardScrolledDown(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
        print("currentCardScrolledDown")
    }
    
    func nextCardScrolledUp(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher) {
        print("nextCardScrolledUp")
    }
    
    private func addSubviews(for cardView: CardView) {
        let logoFrame = CGRect(
            x: 4,
            y: 4,
            width: cardView.frame.size.width-8,
            height: cardView.frame.size.width-30)
        
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 10
        logoImageView.clipsToBounds = true
        logoImageView.backgroundColor = .white
        
        let logo = UIImage(named: "\(String(cardView.indexInCollection)).png")
        logoImageView.image = logo
        cardView.addSubview(logoImageView)
        
        let textFrame = CGRect(
            x: 15,
            y: logoImageView.frame.origin.y+logoImageView.frame.size.height+15,
            width: cardView.frame.size.width-30,
            height: 90)
        let textView = UITextView(frame: textFrame)
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor(red: 0.2078, green: 0.4275, blue: 0.9098, alpha: 1.0)
        textView.textColor = UIColor.white
        textView.text = "The National Basketball Association (NBA) is the major men's professional basketball league in North America, and is widely considered to be the premier men's professional basketball league in the world."
        cardView.addSubview(textView)
    }
    
    private func addStarButton(for cardView: CardView) {
        let starFrame = CGRect(
            x: 20,
            y: cardView.frame.size.height-45,
            width: 30,
            height: 30)
        let starImageView = UIImageView(frame: starFrame)
        starImageView.contentMode = .scaleAspectFit
        starImageView.isUserInteractionEnabled = true
        let starImage = UIImage(named: "star.png")
        starImageView.image = starImage
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleStarTap))
        starImageView.addGestureRecognizer(tapGestureRecognizer)
        guard let tapGestureView = tapGestureRecognizer.view else { return }
        tapGestureView.tag = cardView.indexInCollection
        cardView.addSubview(starImageView)
    }
    
    @objc private func handleStarTap(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let view = tapGestureRecognizer.view else { return }
        guard let logo = UIImage(named: "\(String(view.tag)).png") else { return }
        let activityViewController = UIActivityViewController(activityItems: [logo], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook ]
        present(activityViewController, animated: true, completion: nil)
    }
}

