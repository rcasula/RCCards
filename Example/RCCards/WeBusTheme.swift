//
//  WeBusTheme.swift
//  WeBus
//
//  Created by Roberto Casula on 29/06/18.
//  Copyright © 2018 Roberto Casula. All rights reserved.
//

import UIKit
import RCCards



public struct WeBusTheme: CardPartsTheme {
    public var buttonCornerRadius: CGFloat = 5
    
    
    public var cardsViewContentInsetTop: CGFloat = 16
    public var cardsLineSpacing: CGFloat = 12
    
    public var cardShadow: Bool = false
    
    public var cardCellMargins: UIEdgeInsets = .init(top: 8,
                                                     left: 8,
                                                     bottom: 8,
                                                     right: 8)
    public var cardPartMargins: UIEdgeInsets = .init(top: 8,
                                                     left: 12,
                                                     bottom: 8,
                                                     right: 12)
    
    // CardPartSeparatorView
    public var separatorColor: UIColor = UIColor.turboSeperatorColor
    public var horizontalSeparatorMargins: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    
    // CardPartTextView
    public var smallTextFont: UIFont = UIFont.turboGenericFont(.x_Small)
    public var smallTextColor: UIColor = UIColor.turboCardPartTextColor
    public var normalTextFont: UIFont = UIFont.turboGenericFont(.normal)
    public var normalTextColor: UIColor = UIColor.turboCardPartTextColor
    public var titleTextFont: UIFont = .systemFont(ofSize: 20, weight: .semibold)
    public var titleTextColor: UIColor = UIColor.turboCardPartTitleColor
    public var headerTextFont: UIFont = .systemFont(ofSize: 24, weight: .bold)
    public var headerTextColor: UIColor = UIColor.turboCardPartTitleColor
    public var detailTextFont: UIFont = UIFont.turboGenericFont(.medium)
    public var detailTextColor: UIColor = UIColor.turboCardPartTextColor
    
    // CardPartTitleView
    public var titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
    public var titleColor: UIColor = UIColor.turboCardPartTitleColor
    public var titleViewMargins: UIEdgeInsets = .init(top: 8,
                                                      left: 12,
                                                      bottom: 0,
                                                      right: 12)
    
    // CardPartButtonView
    public var buttonTitleFont: UIFont = UIFont.turboGenericFont(.large)
    public var buttonTitleColor: UIColor = UIColor.turboBlueColor
    
    // CardPartBarView
    public var barBackgroundColor: UIColor = UIColor.turboSeperatorGray
    public var barColor: UIColor = UIColor.turboHeaderBlueColor
    public var todayLineColor: UIColor = UIColor.Gray8
    public var barHeight: CGFloat = 20.0
    public var roundedCorners: Bool = true
    public var showTodayLine: Bool = false
    
    // CardPartTableView
    public var tableViewMargins: UIEdgeInsets = .init(top: 0,
                                                      left: 8,
                                                      bottom: 4,
                                                      right: 8)
    
    // CardPartTableViewCell and CardPartTitleDescriptionView
    public var leftTitleFont: UIFont = UIFont.turboGenericFont(.large)
    public var leftDescriptionFont: UIFont = UIFont.turboGenericFont(.small)
    public var rightTitleFont: UIFont = UIFont.turboGenericFont(.large)
    public var rightDescriptionFont: UIFont = UIFont.turboGenericFont(.small)
    public var leftTitleColor: UIColor = UIColor.turboCardPartTitleColor
    public var leftDescriptionColor: UIColor = UIColor.turboGenericGreyTextColor
    public var rightTitleColor: UIColor = UIColor.turboCardPartTitleColor
    public var rightDescriptionColor: UIColor = UIColor.turboGenericGreyTextColor
    public var secondaryTitlePosition : CardPartSecondaryTitleDescPosition = .center(amount: 0.0)

}
