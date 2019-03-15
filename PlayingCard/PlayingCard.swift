//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Ales Shenshin on 15/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var suit: Suit
    var rank: Rank
    var description: String { return "\(rank)\(suit)" }
    enum Suit: String, CaseIterable, CustomStringConvertible {
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        var description: String { return rawValue }
    }
    enum Rank: CustomStringConvertible {
        case ace
        case numeric(Int)
        case face(String)

        var order: Int {
            switch self {
            case .ace:
                return 1
            case .numeric(let pips):
                return pips
            case .face(let kind) where kind == "J":
                return 11
            case .face(let kind) where kind == "Q":
                return 12
            case .face(let kind) where kind == "K":
                return 13
            default:
                return 0
            }
        }

        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }

        var description: String {
            switch self {
            case .ace:
                return "A"
            case .numeric(let pips):
                return "\(pips)"
            case .face(let kind):
                return kind
            }
        }
    }
}
///валеты🂫🂻🃋🃛
///короли🂮🂾🃎🃞
///дамы🂭🂽🃍🃝
///тузы🂡🂱🃁🃑
///десятки🂪🂺🃊🃚
///девятки🂩🂹🃉🃙
///восьмёрки🂨🂸🃈🃘
///семёрки🂧🂷🃇🃗
///шестёрки🂦🂶🃆🃖
///пятёрки🂥🂵🃅🃕
///четвёрки🂤🂴🃄🃔
///тройки🂣🂳🃃🃓
///двойки🂢🂲🃂🃒
///джокер🃒🃏
