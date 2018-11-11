//
//  UIFont.swift
//  Turbo
//
//  Created by Roossin, Chase on 11/21/17.
//  Copyright © 2017 Intuit, Inc. All rights reserved.
//

public enum FontSize: Int {
    case ultrabig = 48, header = 36, xx_Large = 28, x_Large = 24, large = 17, medium = 16, normal = 14, small = 12, x_Small = 10
}

public extension UIFont {
    
    public class func turboGenericFont(_ fontSize: FontSize) -> UIFont {
        return UIFont(name: ".SFUIDisplay", size: CGFloat(fontSize.rawValue))!
    }
    
    public class func turboGenericFontBlack(_ fontSize: FontSize) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Black", size: CGFloat(fontSize.rawValue))!
    }

    public class func turboGenericFontBold(_ fontSize: FontSize) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Bold", size: CGFloat(fontSize.rawValue))!
    }
    
    public class func turboGenericMediumFont(_ fontSize: FontSize) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Medium", size: CGFloat(fontSize.rawValue))!
    }
    
    public class func turboGenericLightFont(_ fontSize: FontSize) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Light", size: CGFloat(fontSize.rawValue))!
    }
    
    public class func turboGenericFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIDisplay", size: size)!
    }
    
    public class func turboGenericMediumFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Medium", size: size)!
    }
    
    public class func turboGenericLightFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIDisplay-Light", size: size)!
    }
}
