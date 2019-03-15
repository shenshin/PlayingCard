//
//  Extensions.swift
//  Concentration
//
//  Created by Ales Shenshin on 05/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

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
