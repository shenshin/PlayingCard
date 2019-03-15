//
//  ViewController.swift
//  PlayingCard
//
//  Created by Ales Shenshin on 14/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

}
