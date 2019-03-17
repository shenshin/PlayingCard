//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Ales Shenshin on 15/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {

    var rank: Int = 13 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }

    private var cornerString: NSAttributedString {
        return centeredAttributedString(rankString+"\n"+suit, fontSize: cornerFontSize)
    }
    private lazy var upperleftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()

    //создаёт label и делает его подвидом (дочерним видом) текущего view
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }

    //draw нельзя вызывать явно. Он вызывается системой при отрисовке view
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()//это ограничивает дальнеейшее рисование границами данной фигуры
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).setFill()
        roundedRect.fill()
        if let faceCardImage = UIImage(named: rankString+suit) {
            faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
        }
    }

    //этот метод вызывается, когда view перерисовывается. Вызывать явно его не нужно! (как и draw)
    //он вызывается системой при вызове метода setNeedsLayout()
    override func layoutSubviews() {
        super.layoutSubviews()
        //отформатировать значок "карты и масти", который сидит в label
        configureCornerLabel(upperleftCornerLabel)
        configureCornerLabel(lowerRightCornerLabel)
        //разместить его в нужном месте на карте
        upperleftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        lowerRightCornerLabel.frame.origin =
//Это был мой вариант, который тоже отлично работает
//            CGPoint(x: bounds.maxX - cornerOffset - lowerRightCornerLabel.bounds.width,
//                    y: bounds.maxY - cornerOffset - lowerRightCornerLabel.bounds.height)
        CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset,
                      dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width,
                      dy: -lowerRightCornerLabel.frame.size.height)
        //Перевернуть нижнее название карты вверх ногами
        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
    }

    //при изменении размера текста перерисовать содержимое (встроенный метод)
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }

    //оформление значка карты в правом нижнем и левом верхнем углах
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }

    //установить параметры текста, которым отрисовывается значок карты
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        //эта строка нужна чтобы если владелец телефона увеличил настройки размеров шрифтов
        //в системе, мой шрифт тоже увеличился пропорционально остальным шрифтам
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string,
                                  attributes: [.paragraphStyle: paragraphStyle,
                                               .font: font])
    }
}

//здесь устанавливаются всяческие константы и вспомогательные методы
extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}
// Здесь приведён пример того, как рисовать при помощи контекста, а не UIBezierPath()
//
//        guard let context = UIGraphicsGetCurrentContext() else {fatalError("Can't get graphics context")}
//        context.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
//                       radius: 100,
//                       startAngle: 0,
//                       endAngle: CGFloat.pi*2,
//                       clockwise: true)
//        context.setLineWidth(5)
//        UIColor.red.setFill()
//        UIColor.red.setStroke()
//        //context.strokePath()
//        context.fillPath()
//contentMode = .redraw
