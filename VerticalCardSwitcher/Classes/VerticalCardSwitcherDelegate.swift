//
//  VerticalCardSwitcherDelegate.swift
//  Pods
//
//  Created by Matija Kruljac on 20/05/2017.
//
//

import Foundation

@objc public protocol VerticalCardSwitcherDelegate {
    
    func numberOfCards(for verticalCardSwitcher: VerticalCardSwitcher) -> Int
    func distanceBetweenCards(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat
    func heightForCardView(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat
    func sideMargins(for verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat
    func addDesign(for cardView: CardView, at index: Int, in verticalCardSwitcher: VerticalCardSwitcher)
    func heightOfShowedPartForEveryNextCard(in verticalCardSwitcher: VerticalCardSwitcher) -> CGFloat
    
    @objc optional func nextCardScrolledUp(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher)
    @objc optional func currentCardScrolledDown(cardView: CardView, for verticalCardSwitcher: VerticalCardSwitcher)
}
