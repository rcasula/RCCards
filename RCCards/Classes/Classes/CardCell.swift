//
//  CardCell.swift
//  CardParts2
//
//  Created by Kier, Tom on 1/17/17.
//  Copyright © 2017 Kier, Tom. All rights reserved.
//

import UIKit
import SnapKit


open class CardCell : UICollectionViewCell {
    
    var cardContentView: UIView
    var cardContentConstraints = [NSLayoutConstraint]()
//    var topBottomMarginConstraints = [NSLayoutConstraint]()
    var cardTopAccentView: UIView
    var topMarginConstraint: Constraint?
    var bottomMarginConstraint: Constraint?
    var topAccentHeightConstraint: Constraint?
    
    private var topAccentHeight: CGFloat = 0
    private var topAccentBackgroundColor: UIColor = .clear {
        didSet {
            cardTopAccentView.backgroundColor = topAccentBackgroundColor
        }
    }
    
    private var currentSize = CGSize.zero
    private var gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        cardContentView = UIView()
        cardContentView.translatesAutoresizingMaskIntoConstraints = false
        
        cardTopAccentView = UIView()
        cardTopAccentView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.Gray7.cgColor
        contentView.layer.borderWidth = 0.5
        if CardParts.theme.cardShadow {
            contentView.layer.shadowColor = UIColor.Gray7.cgColor
            contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
            contentView.layer.shadowRadius = 1.0
            contentView.layer.shadowOpacity = 0.9
        }
        
        contentView.addSubview(cardTopAccentView)
        contentView.addSubview(cardContentView)
        contentView.backgroundColor = UIColor.white
        
        contentView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.safeAreaInsets)
            } else {
                make.edges.equalTo(self)
            }
        }
        
        cardTopAccentView.snp.makeConstraints { [weak self] make in
            guard let sSelf = self else { return }
            if #available(iOS 11.0, *) {
                make.leading.equalTo(sSelf.safeAreaInsets)
                make.trailing.equalTo(sSelf.safeAreaInsets)
                make.top.equalTo(sSelf.safeAreaInsets)
            } else {
                make.leading.equalTo(sSelf)
                make.trailing.equalTo(sSelf)
                make.top.equalTo(sSelf)
            }
            sSelf.topAccentHeightConstraint = make.height
                                                  .equalTo(sSelf.topAccentHeight)
                                                  .constraint
        }

        cardContentView.snp.makeConstraints { [weak self] make in
            guard let sSelf = self else { return }
            if #available(iOS 11.0, *) {
                make.leading.equalTo(sSelf.safeAreaInsets)
                make.trailing.equalTo(sSelf.safeAreaInsets)
            } else {
                make.leading.equalTo(sSelf)
                make.trailing.equalTo(sSelf)
            }
//            sSelf.topMarginConstraint = make.top
//                                            .equalTo(contentView)
//                                            .offset(CardParts.theme.cardCellMargins.top)
//                                            .constraint
            sSelf.topMarginConstraint = make.top
                                            .equalTo(cardTopAccentView.snp.bottom)
                                            .offset(CardParts.theme.cardCellMargins.top)
                                            .constraint
            sSelf.bottomMarginConstraint = make.bottom
                                               .equalTo(contentView)
                                               .offset(CardParts.theme.cardCellMargins.bottom)
                                               .constraint
        }
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        gestureRecognizers?.forEach { removeGestureRecognizer($0) }
    }
    
    override open var bounds: CGRect {
        didSet {
            contentView.frame = bounds
            gradientLayer.frame = self.bounds
        }
    }
    
    var gradientColors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = gradientColors.map({ (color) -> CGColor in
                return color.cgColor
            })
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.borderWidth = 0.0
        }
    }
    
    var gradientAngle: Float = 0 {
        didSet {
            let alpha: Float = gradientAngle / 360
            let startPointX = powf(
                sinf(2 * Float.pi * ((alpha + 0.75) / 2)),
                2
            )
            let startPointY = powf(
                sinf(2 * Float.pi * ((alpha + 0) / 2)),
                2
            )
            let endPointX = powf(
                sinf(2 * Float.pi * ((alpha + 0.25) / 2)),
                2
            )
            let endPointY = powf(
                sinf(2 * Float.pi * ((alpha + 0.5) / 2)),
                2
            )
            gradientLayer.endPoint = CGPoint(x: CGFloat(endPointX),y: CGFloat(endPointY))
            gradientLayer.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
        }
    }
    
    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let desiredHeight: CGFloat = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        if currentSize.height != desiredHeight || currentSize != layoutAttributes.size {
            let attr = super.preferredLayoutAttributesFitting(layoutAttributes)
            attr.frame.size.height = desiredHeight
            currentSize = attr.frame.size
            return attr
        }
        return layoutAttributes
    }
    
    func requiresNoTopBottomMargins(_ noTopBottomMargins: Bool) {
        
        if noTopBottomMargins {
            topMarginConstraint?.update(offset: 0)
            bottomMarginConstraint?.update(offset: 0)
        } else {
            topMarginConstraint?.update(offset: 9)
            bottomMarginConstraint?.update(offset: 12)
        }
    }
    
    func addTopAccent(of height: CGFloat, color: UIColor) {
        self.topAccentHeight = height
        
        self.topAccentHeightConstraint?.deactivate()
        
        cardTopAccentView.snp.makeConstraints { [weak self] make in
            guard let sSelf = self else { return }
            sSelf.topAccentHeightConstraint = make.height
                .equalTo(sSelf.topAccentHeight)
                .constraint
        }
        
        topAccentBackgroundColor = color
    }
    
    func requiresTransparentCard(transparentCard: Bool) {
        if transparentCard {
            contentView.backgroundColor = UIColor.clear
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.borderWidth = 0.0
            contentView.layer.shadowColor = UIColor.clear.cgColor
            contentView.layer.shadowOffset = CGSize.zero
            contentView.layer.shadowRadius = 0.0
            contentView.layer.shadowOpacity = 0.0
        } else {
            contentView.backgroundColor = UIColor.white
            contentView.layer.borderColor = UIColor.Gray7.cgColor
            contentView.layer.borderWidth = 0.5
            if CardParts.theme.cardShadow {
                contentView.layer.shadowColor = UIColor.Gray7.cgColor
                contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
                contentView.layer.shadowRadius = 1.0
                contentView.layer.shadowOpacity = 0.9
            }
        }
    }
    
    func addShadowToCard(shadowRadius: CGFloat = 8.0, shadowOpacity: Float = 0.7, shadowColor: CGColor = UIColor.Gray2.cgColor) {
        contentView.layer.shadowColor = shadowColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = shadowRadius
        contentView.layer.shadowOpacity = shadowOpacity
    }
    
    func setCornerRadius(radius: CGFloat) {
        contentView.layer.cornerRadius = radius
        cardTopAccentView.layer.cornerRadius = radius
        gradientLayer.cornerRadius = radius
        
        cardTopAccentView.roundCorners([.topLeft, .topRight], radius: radius)
    }
    
    func addLongGestureRecognizer(minimumPressDuration: CFTimeInterval, delegate: CardPartsLongPressGestureRecognizerDelegate) {
        let longGesture = UILongPressGestureRecognizer(target: delegate, action: #selector(CardPartsLongPressGestureRecognizerDelegate.didLongPress(_:)))
        longGesture.minimumPressDuration = minimumPressDuration
        self.addGestureRecognizer(longGesture)
    }
    
    override open func updateConstraints() {
        super.updateConstraints()
    }
}



