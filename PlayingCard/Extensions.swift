//
//  Extensions.swift
//  Concentration
//
//  Created by Ales Shenshin on 05/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
    static postfix func ++ (lhs: inout Int) {
        lhs += 1
    }
    static postfix func -- (lhs: inout Int) {
        lhs -= 1
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    func oneAndOnlyElement() -> Element? {
        return count == 1 ? first : nil
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
    }
}
extension CGPoint {
    func offsetBy(dx xOffset: CGFloat, dy yOffset: CGFloat) -> CGPoint {
        return CGPoint(x: x + xOffset, y: y + yOffset)
    }
}
