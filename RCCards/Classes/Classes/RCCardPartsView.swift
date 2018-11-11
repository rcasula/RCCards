//
//  RCCardPartsView.swift
//  RCCards
//
//  Created by Roberto Casula on 11/11/2018.
//

import UIKit
import SnapKit

open class RCCardPartsView: UIView, RCCard {
    public var view: UIView {
        return self
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setupCardParts(_ cardParts: [CardPartView]) {
        setNeedsLayout()
        var prevCardPart: UIView = self
        var padding: CGFloat = 0
        
        for cardPart in cardParts {
            cardPart.view.translatesAutoresizingMaskIntoConstraints = false
            
            padding += cardPart.margins.top
            
            addSubview(cardPart.view)
            
            cardPart.view.snp.makeConstraints { [weak self] make in
                guard let sSelf = self else { return }
                if #available(iOS 11.0, *) {
                    make.leading.equalTo(sSelf.safeAreaInsets).offset(cardPart.margins.left)
                    make.trailing.equalTo(sSelf.safeAreaInsets).offset(-cardPart.margins.right)
                } else {
                    make.leading.equalTo(sSelf).offset(cardPart.margins.left)
                    make.trailing.equalTo(sSelf).offset(-cardPart.margins.right)
                }
            }
            
            if prevCardPart == self {
                cardPart.view.snp.makeConstraints { [weak self] make in
                    guard let sSelf = self else { return }
                    make.top.equalTo(sSelf).offset(padding)
                }
            } else {
                cardPart.view.snp.makeConstraints { make in
                    make.top.equalTo(prevCardPart.snp.bottom).offset(padding)
                }
            }
            
            prevCardPart = cardPart.view
            padding = cardPart.margins.bottom
        }
        
        self.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(prevCardPart.snp.bottom).offset(padding)
        }
        
        invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }
}
