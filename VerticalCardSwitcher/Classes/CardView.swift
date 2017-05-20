//
//  CardView.swift
//  Pods
//
//  Created by Matija Kruljac on 5/19/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation
import UIKit

public class CardView: UIView {
    
    private(set) public var panGestureRecognizer: UIPanGestureRecognizer!
    private(set) public var indexInCollection: Int!
    
    public init(frame: CGRect, with indexInCollection: Int, andWith panGestureRecognizer: UIPanGestureRecognizer) {
        super.init(frame: frame)
        self.panGestureRecognizer = panGestureRecognizer
        self.indexInCollection = indexInCollection
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setup(design: ()->()) {
        design()
    }
}
