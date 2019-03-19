//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Ales Shenshin on 15/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private var deck: [PlayingCard] = []
    init() {
        for suite in PlayingCard.Suit.allCases {
            for rank in PlayingCard.Rank.allCases {
                deck.append(PlayingCard(suit: suite, rank: rank))
            }
        }
    }
    mutating func draw() -> PlayingCard? {
        if !deck.isEmpty {
            return deck.remove(at: deck.count.arc4random)
        } else {
            return nil
        }
    }
}
