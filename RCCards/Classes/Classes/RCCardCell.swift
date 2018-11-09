//
//  RCCardCell.swift
//  RCCards
//
//  Created by Roberto Casula on 09/11/2018.
//

import UIKit

open class RCCardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardContentView: UIView!
    
    private var currentSize = CGSize.zero
    
    override open var bounds: CGRect {
        didSet {
            contentView.frame = bounds
//            gradientLayer.frame = self.bounds
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        contentView.backgroundColor = UIColor.white
        
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
}
