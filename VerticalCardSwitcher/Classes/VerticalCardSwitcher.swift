//
//  VerticalCardSwitcher.swift
//  Pods
//
//  Created by Matija Kruljac on 5/19/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol VerticalCardSwitcherDelegate {
    
    func numberOfCards() -> Int
    func distanceBetweenCards() -> CGFloat
    func design(for cardView: CardView, at index: Int)
    
    @objc optional func nextCardStartedScrollingUp(cardView: CardView)
    @objc optional func currentCardStartedScrollingDown(cardView: CardView)
    
    @objc optional func nextCardScrolledUp(cardView: CardView)
    @objc optional func currentCardScrolledDown(cardView: CardView)
}

public class VerticalCardSwitcher {
    
    public weak var delegate: VerticalCardSwitcherDelegate?
    
    private var cards = [CardView]()
    private var viewControllerView: UIView!
    
    private var yOriginCurrentCard: CGFloat!
    private var xOriginCurrentCard: CGFloat!
    
    private var currentCardFrame = CGRect.zero
    private var nextCardFrame = CGRect.zero
    
    private let initialNumberOfAddedCardsToSuperView = 3
    
    public init(in viewControllerView: UIView) {
        self.viewControllerView = viewControllerView
    }
    
    public func setupMarginsAndInitialFrames(top yOriginCurrentCard: CGFloat, sides xOriginCurrentCard: CGFloat) {
        self.xOriginCurrentCard = viewControllerView.frame.origin.x + xOriginCurrentCard
        self.yOriginCurrentCard = viewControllerView.frame.origin.y + yOriginCurrentCard
        self.setupInitialFrames()
    }
    
    private func setupInitialFrames() {
        guard let delegate = delegate else { return }
        currentCardFrame = CGRect(
            x: xOriginCurrentCard,
            y: yOriginCurrentCard,
            width: viewControllerView.frame.size.width - 2*xOriginCurrentCard,
            height: 0.70 * viewControllerView.frame.size.height)
        
        nextCardFrame = CGRect(
            x: xOriginCurrentCard,
            y: yOriginCurrentCard + currentCardFrame.size.height + delegate.distanceBetweenCards(),
            width: viewControllerView.frame.size.width - 2*xOriginCurrentCard,
            height: 0.70 * viewControllerView.frame.size.height)
    }
    
    public func display() {
        guard let delegate = delegate else { return }
        var yOriginNextCard: CGFloat = yOriginCurrentCard
        
        for index in 0...delegate.numberOfCards() - 1 {
            let cardFrame = CGRect(
                x: xOriginCurrentCard,
                y: yOriginNextCard,
                width: viewControllerView.frame.size.width - 2*xOriginCurrentCard,
                height: 0.70 * viewControllerView.frame.size.height)
            
            let cardView = CardView.init(frame: cardFrame, with: index)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            cardView.addGestureRecognizer(panGestureRecognizer)
            delegate.design(for: cardView, at: index)
            cards.append(cardView)
            
            if index <= initialNumberOfAddedCardsToSuperView {
                viewControllerView.addSubview(cardView)
            }
            yOriginNextCard += currentCardFrame.size.height + delegate.distanceBetweenCards()
        }
    }
    
    @objc private func handlePanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        guard let cardView = panGestureRecognizer.view as? CardView else { return }
        viewControllerView.bringSubview(toFront: cardView)
        let velocity = panGestureRecognizer.velocity(in: viewControllerView)
        
        if panGestureRecognizer.state == .began || panGestureRecognizer.state == .changed {
            if foundedUndesiredState(for: cardView, with: velocity) {
                return
            }
            
            let translation = panGestureRecognizer.translation(in: viewControllerView)
            cardView.center = CGPoint(x: cardView.center.x, y: cardView.center.y + translation.y)
            makeScaleDepthEffect(with: panGestureRecognizer, for: cardView)
            handleDelegateWhenStartedScrolling(with: panGestureRecognizer, for: cardView)
            panGestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: viewControllerView)
        }
        
        if panGestureRecognizer.state == .ended {
            setupNewFrameForCardViewAndMakeItCurrent(panGestureRecognizer: panGestureRecognizer, with: cardView)
            resetFrameAndAnimateWhenPanGestureIsEnded(panGestureRecognizer: panGestureRecognizer, with: cardView)
            handleDelegateWhenFinishedScrolling(with: panGestureRecognizer, for: cardView)
        }
    }
    
    private func foundedUndesiredState(for cardView: CardView, with velocity: CGPoint) -> Bool {
        // undesired state
        if cardView.frame.origin.y <= yOriginCurrentCard && velocity.y <= 0 {
            return true
        }
        // undesired state
        if cardView.indexInCollection == 0 && velocity.y >= 0 {
            return true
        }
        return false
    }
    
    private func makeScaleDepthEffect(with panGestureRecognizer: UIPanGestureRecognizer, for cardView: CardView) {
        // scale - depth effect
        switch panGestureRecognizer.determineVerticalDirection(for: cardView) {
        case .up:
            scale(cardView, withFactor: 0.85)
        case .down:
            scale(cardView, withFactor: 1.0)
        }
    }
    
    private func handleDelegateWhenStartedScrolling(with panGestureRecognizer: UIPanGestureRecognizer, for cardView: CardView) {
        switch panGestureRecognizer.determineVerticalDirection(for: cardView) {
        case .up:
            delegate?.nextCardStartedScrollingUp?(cardView: cardView)
        case .down:
            delegate?.currentCardStartedScrollingDown?(cardView: cardView)
        }
    }
    
    private func handleDelegateWhenFinishedScrolling(with panGestureRecognizer: UIPanGestureRecognizer, for cardView: CardView) {
        let panDirection: UIPanGestureRecognizer.PanDirection = panGestureRecognizer.determineVerticalDirection(for: cardView)
        if cardView.center.y <= 650 && panDirection == .up {
            delegate?.nextCardScrolledUp?(cardView: cardView)
        }
        if cardView.center.y >= 420 && panDirection == .down {
            delegate?.currentCardScrolledDown?(cardView: cardView)
        }
    }
    
    private func changeAnimatedNextCardFrame(for cardView: CardView) {
        if #available(iOS 10.0, *) {
            let viewAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
                cardView.frame = self.nextCardFrame
            })
            viewAnimator.startAnimation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func changeAnimatedCurrentCardFrame(for cardView: CardView) {
        if #available(iOS 10.0, *) {
            let viewAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
                cardView.frame = self.currentCardFrame
            })
            viewAnimator.startAnimation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func setupNewFrameForCardViewAndMakeItCurrent(panGestureRecognizer: UIPanGestureRecognizer, with cardView: CardView) {
        let panDirection: UIPanGestureRecognizer.PanDirection = panGestureRecognizer.determineVerticalDirection(for: cardView)
        if (cardView.center.y <= 650 && panDirection == .up) || (cardView.center.y < 420 && panDirection == .down) {
            addAndRemoveNeighbouringCardViewsOnScrollUp(forCurrentView: cardView.indexInCollection)
            changeAnimatedCurrentCardFrame(for: cardView)
            setupFrameForNextCardView(after: cardView)
        }
        if cardView.center.y >= 420 && panDirection == .down {
            addAndRemoveNeighbouringCardViewsOnScrollDown(forCurrentView: cardView.indexInCollection)
            changeAnimatedNextCardFrame(for: cardView)
        }
    }
    
    private func resetFrameAndAnimateWhenPanGestureIsEnded(panGestureRecognizer: UIPanGestureRecognizer, with cardView: CardView) {
        if cardView.center.y >= 420 {
            changeAnimatedNextCardFrame(for: cardView)
            scale(cardView, withFactor: 1.0)
        } else if cardView.center.y <= 650 {
            changeAnimatedCurrentCardFrame(for: cardView)
            scale(cardView, withFactor: 0.85)
        }
        viewControllerView.bringSubview(toFront: panGestureRecognizer.view!)
    }
    
    private func setupFrameForNextCardView(after cardView: CardView) {
        if cardView.indexInCollection > 0 && cardView.indexInCollection + 1 < cards.count {
            let nextCardView: CardView = self.cards[cardView.indexInCollection + 1]
            nextCardView.frame = self.nextCardFrame
        }
    }
    
    private func scale(_ cardView: CardView, withFactor factor: CGFloat) {
        if cardView.indexInCollection > 0 {
            if #available(iOS 10.0, *) {
                let viewAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
                    let previousCardView: CardView = self.cards[cardView.indexInCollection - 1]
                    previousCardView.transform = CGAffineTransform(scaleX: factor, y: factor)
                })
                viewAnimator.startAnimation()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private func addAndRemoveNeighbouringCardViewsOnScrollUp(forCurrentView index: Int) {
        if index >= 2 && index < cards.count - 1 {
            let belowCurrentCardView = cards[index - 2]
            belowCurrentCardView.removeFromSuperview()
            
            let nextCardView = cards[index + 1]
            viewControllerView.addSubview(nextCardView)
        }
    }
    
    private func addAndRemoveNeighbouringCardViewsOnScrollDown(forCurrentView index: Int) {
        if index >= 2 && index < cards.count - 1 {
            let currentCardView = cards[index - 1]
            let belowCurrentCardView = cards[index - 2]
            viewControllerView.addSubview(belowCurrentCardView)
            viewControllerView.bringSubview(toFront: currentCardView)
            
            let nextCardView = cards[index + 1]
            nextCardView.removeFromSuperview()
        }
    }
}
