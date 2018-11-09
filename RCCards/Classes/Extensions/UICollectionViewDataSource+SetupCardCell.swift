//
//  UICollectionViewDataSource+SetupCardCell.swift
//  RCCards
//
//  Created by Roberto Casula on 09/11/2018.
//

import UIKit
import SnapKit


public extension UICollectionView {
    
    public func dequeueReusableCardCell(withReuseIdentifier identifier: String,
                                        for indexPath: IndexPath,
                                        cardController: CardController,
                                        parentController: UIViewController) -> CardCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CardCell

        let viewController = cardController.viewController()

        if cell.cardContentView.subviews.count == 0 {

            var noTopBottomMargins = false
            if let noTopBottomMarginsCardTrait = cardController as? NoTopBottomMarginsCardTrait {
                noTopBottomMargins = noTopBottomMarginsCardTrait.requiresNoTopBottomMargins()
            }
            cell.requiresNoTopBottomMargins(noTopBottomMargins)

            var transparentCard = false
            if let transparentCardTrait = cardController as? TransparentCardTrait {
                transparentCard = transparentCardTrait.requiresTransparentCard()
            }
            cell.requiresTransparentCard(transparentCard: transparentCard)

            if let shadowCardTrait = cardController as? ShadowCardTrait {
                cell.addShadowToCard(shadowRadius: shadowCardTrait.shadowRadius(), shadowOpacity: shadowCardTrait.shadowOpacity(), shadowColor: shadowCardTrait.shadowColor())
            }

            if let roundedCardTrait = cardController as? RoundedCardTrait {
                cell.setCornerRadius(radius: roundedCardTrait.cornerRadius())
            }

            if let gradientCardTrait = cardController as? GradientCardTrait {
                cell.gradientColors = gradientCardTrait.gradientColors()
                cell.gradientAngle = gradientCardTrait.gradientAngle?() ?? 0
            }

            if let longGestureDelegate = cardController as? CardPartsLongPressGestureRecognizerDelegate {
                cell.addLongGestureRecognizer(minimumPressDuration: longGestureDelegate.minimumPressDuration, delegate: longGestureDelegate)
            }

            cell.cardContentView.subviews.forEach { $0.removeFromSuperview() }
            viewController.view.removeFromSuperview()

            let hasParent = viewController.parent != nil
            if !hasParent {
                parentController.addChild(viewController)
            }

            cell.cardContentView.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            var safeAreaWidth: CGFloat = 0
            if #available(iOS 11.0, *) {
                safeAreaWidth = parentController.view.safeAreaInsets.left + parentController.view.safeAreaInsets.right
            }
            
            let width = parentController.view.bounds.size.width - safeAreaWidth - (CardParts.theme.cardCellMargins.left + CardParts.theme.cardCellMargins.right)
            viewController.view.snp.makeConstraints { make in
                if #available(iOS 11.0, *) {
                    make.leading.equalTo(cell.cardContentView).priority(900)
                    make.trailing.equalTo(cell.cardContentView).priority(900)
                } else {
                    make.leading.equalTo(cell.cardContentView).priority(900)//.inset(CardParts.theme.cardCellMargins.left).priority(900)
                    make.trailing.equalTo(cell.cardContentView).priority(900)//.inset(-CardParts.theme.cardCellMargins.right).priority(900)
                }
                make.width.equalTo(width)
                make.top.equalTo(cell.cardContentView)
                make.bottom.equalTo(cell.cardContentView)
            }

//            if getEditModeForIndexPath(indexPath: indexPath) {
//                let editButton = UIButton(frame: CGRect(x: view.bounds.size.width - editButtonOffset - editButtonWidth, y: 0, width: editButtonWidth, height: editButtonHeight))
//                editButton.setImage(UIImage(named: editButtonImage, in: Bundle(for: CardsViewController.self), compatibleWith: nil), for: .normal)
//                editButton.addTargetClosure { _ in
//                    if let editibalCardTrait = cardController as? EditableCardTrait {
//                        editibalCardTrait.onEditButtonTap()
//                    }
//                }
//                cell.contentView.addSubview(editButton)
//            }
            if !hasParent {
                viewController.didMove(toParent: parentController)
            }
        }

        cell.cardContentView.layoutIfNeeded()
        cell.cardContentView.updateConstraints()
        
        return cell
    }
    
    
//    public func dequeueReusableCardCell(withReuseIdentifier identifier: String,
//                                        for indexPath: IndexPath,
//                                        cardController: CardController,
//                                        parentController: UIViewController) -> RCCardCell {
//        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RCCardCell
//        cell.bounds = .init(x: 0, y: 0, width: 5, height: 5)
//        let viewController = cardController.viewController()
//
//        if cell.cardContentView.subviews.count == 0 {
//
//            //            var noTopBottomMargins = false
//            //            if let noTopBottomMarginsCardTrait = cardController as? NoTopBottomMarginsCardTrait {
//            //                noTopBottomMargins = noTopBottomMarginsCardTrait.requiresNoTopBottomMargins()
//            //            }
//            //            cell.requiresNoTopBottomMargins(noTopBottomMargins)
//            //
//            //            var transparentCard = false
//            //            if let transparentCardTrait = cardController as? TransparentCardTrait {
//            //                transparentCard = transparentCardTrait.requiresTransparentCard()
//            //            }
//            //            cell.requiresTransparentCard(transparentCard: transparentCard)
//            //
//            //            if let shadowCardTrait = cardController as? ShadowCardTrait {
//            //                cell.addShadowToCard(shadowRadius: shadowCardTrait.shadowRadius(), shadowOpacity: shadowCardTrait.shadowOpacity(), shadowColor: shadowCardTrait.shadowColor())
//            //            }
//            //
//            //            if let roundedCardTrait = cardController as? RoundedCardTrait {
//            //                cell.setCornerRadius(radius: roundedCardTrait.cornerRadius())
//            //            }
//            //
//            //            if let gradientCardTrait = cardController as? GradientCardTrait {
//            //                cell.gradientColors = gradientCardTrait.gradientColors()
//            //                cell.gradientAngle = gradientCardTrait.gradientAngle?() ?? 0
//            //            }
//            //
//            //            if let longGestureDelegate = cardController as? CardPartsLongPressGestureRecognizerDelegate {
//            //                cell.addLongGestureRecognizer(minimumPressDuration: longGestureDelegate.minimumPressDuration, delegate: longGestureDelegate)
//            //            }
//
//            cell.cardContentView.subviews.forEach { $0.removeFromSuperview() }
//            viewController.view.removeFromSuperview()
//
//            let hasParent = viewController.parent != nil
//            if !hasParent {
//                parentController.addChild(viewController)
//            }
//
//            cell.cardContentView.addSubview(viewController.view)
//            viewController.view.translatesAutoresizingMaskIntoConstraints = false
//
//
//            cell.cardContentView.removeConstraints(cell.cardContentView.constraints)
////            cell.cardContentConstraints.removeAll()
////
//            let metrics = ["cardContentWidth": parentController.view.bounds.size.width - (CardParts.theme.cardCellMargins.left + CardParts.theme.cardCellMargins.right)]
////            cell.cardContentConstraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "H:|[view(cardContentWidth)]|", options: [], metrics: metrics, views: ["view" : viewController.view]))
//            cell.cardContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: metrics, views: ["view" : viewController.view]))
//            //            cell.cardContentConstraints.append(contentsOf:NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view" : viewController.view]))
//            cell.cardContentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view" : viewController.view]))
//
//            //            cell.cardContentView.addConstraints(cell.cardContentConstraints)
//            //            if getEditModeForIndexPath(indexPath: indexPath) {
//            //                let editButton = UIButton(frame: CGRect(x: view.bounds.size.width - editButtonOffset - editButtonWidth, y: 0, width: editButtonWidth, height: editButtonHeight))
//            //                editButton.setImage(UIImage(named: editButtonImage, in: Bundle(for: CardsViewController.self), compatibleWith: nil), for: .normal)
//            //                editButton.addTargetClosure { _ in
//            //                    if let editibalCardTrait = cardController as? EditableCardTrait {
//            //                        editibalCardTrait.onEditButtonTap()
//            //                    }
//            //                }
//            //                cell.contentView.addSubview(editButton)
//            //            }
//            if !hasParent {
//                viewController.didMove(toParent: parentController)
//            }
//        }
//
//        cell.cardContentView.layoutIfNeeded()
//        cell.cardContentView.updateConstraints()
//        //        cell.contentView.layoutIfNeeded()
//        //        cell.contentView.updateConstraints()
//
//        return cell
//    }
    
    
    public func registerCardCell() {
//        let nib = UINib(nibName: "RCCardCell", bundle: Bundle(for: RCCardCell.self))
//        self.register(nib, forCellWithReuseIdentifier: "cell")
        self.register(CardCell.self, forCellWithReuseIdentifier: "cell")
    }
    
}
