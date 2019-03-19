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
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            /// Узнаватель смахивания карты вправо или влево
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            /// Узнаватель жеста масштабирования
            let pinch = UIPinchGestureRecognizer(target: playingCardView,
            action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizerBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }

    @objc func nextCard() {
        // карты в колоде ещё не кончились и карта лицом вверх,
        // чтобы когда карта вверх рубашкой, смахивания не срабатывали
        if let card = deck.draw(), playingCardView.isFaceUp {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }

    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: //вызывается когда тап по карте закончен
            playingCardView.isFaceUp.toggle()
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
