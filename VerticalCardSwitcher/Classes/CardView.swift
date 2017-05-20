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
    
    public var indexInCollection: Int!
    
    public init(frame: CGRect, with indexInCollection: Int) {
        self.indexInCollection = indexInCollection
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setup(design: ()->()) {
        design()
    }
}
