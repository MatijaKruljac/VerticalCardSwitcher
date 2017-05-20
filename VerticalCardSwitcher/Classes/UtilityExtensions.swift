//
//  UtilityExtensions.swift
//  Pods
//
//  Created by Matija Kruljac on 5/19/17.
//  Copyright © 2017 Matija Kruljac. All rights reserved.
//

import Foundation

public extension UIPanGestureRecognizer {
    
    enum PanDirection {
        case up
        case down
    }
    
    func determineVerticalDirection(for view: CardView) -> PanDirection {
        return self.velocity(in: view).y > 0 ? .down : .up
    }
}

public extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

public extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
