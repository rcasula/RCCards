//
//  UIColor.swift
//  Turbo
//
//  Created by Roossin, Chase on 11/21/17.
//  Copyright © 2017 Intuit, Inc. All rights reserved.
//

public extension UIColor {
    
    public static var turboGenericGreyTextColor : UIColor {get{return UIColor.color(169, green: 169, blue: 169)}}
    public static var turboCardPartTitleColor : UIColor {get{return UIColor.color(17, green: 17, blue: 17)}}
    public static var turboCardPartTextColor : UIColor {get{return UIColor.color(136, green: 136, blue: 136)}}
    public static var turboSeperatorColor : UIColor {get{return UIColor.color(221, green: 221, blue: 221)}}
    public static var turboBlueColor : UIColor {get{return UIColor(red: 69.0/255.0, green: 202.0/255.0, blue: 230.0/255.0, alpha: 1.0)}}
    public static var turboHeaderBlueColor: UIColor { get { return UIColor.colorFromHex(0x05A4B5) }}
    public static var turboGreenColor : UIColor {get{return UIColor(red: 10.0/255.0, green: 199.0/255.0, blue: 117.0/255.0, alpha: 1.0)}}
    public static var turboSeperatorGray : UIColor {get{return UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0)}}
    public static var Black : UIColor {get{return UIColor.colorFromHex(0x000000)}}
    public static var Gray0 : UIColor {get{return UIColor.colorFromHex(0x333333)}}
    public static var Gray1 : UIColor {get{return UIColor.colorFromHex(0x666666)}}
    public static var Gray2 : UIColor {get{return UIColor.colorFromHex(0x999999)}}
    public static var Gray3 : UIColor {get{return UIColor.colorFromHex(0xCCCCCC)}}
    public static var Gray4 : UIColor {get{return UIColor.colorFromHex(0xDDDDDD)}}
    public static var Gray5 : UIColor {get{return UIColor.colorFromHex(0xF0F0F0)}}
    public static var Gray6 : UIColor {get{return UIColor.colorFromHex(0xF5F5F5)}}
    public static var Gray7 : UIColor {get{return UIColor.colorFromHex(0xE7E7E7)}}
    public static var Gray8 : UIColor {get{return UIColor.colorFromHex(0xB2B2B2)}}
    
    public class func color(_ red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
    
    public static func colorFromHex(_ rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
