//
//  UIColor+Ext.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

extension UIColor {
    
    
    /// Create a new UIColor from a hex (#HHHHHHHH) string. hex string could be either # plus any 6 or 8 string length. The hex is simply divided as: `#{RED_COLOR_HEX 2 = hex}{GREEN_COLOR_HEX = 2 hex}{BLUE_COLOR_HEX = 2}{ALPHA_HEX = 2 (optional)}`. for example: the hex `#000000` and `#000000FF` represents the `black` color. and  `#00000000` represent the `clear` color.
    /// - Parameter hex: <#hex description#>
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    a = 1
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    ///  Lighten the `color` in the gray-scale by the given precentage.
    /// For example, if you pass `UIColor.black` as the first argument, and lighten it by `100` precent, you should get: `#FFFFFF` (`white` color).
    /// - Parameters:
    ///   - color: The `UIColor` to lighten
    ///   - percentage: The precentage to lighten the color with
    /// - Returns: The lightened color.
    class func lighten(_ color: UIColor, by percentage: CGFloat = 30.0) -> UIColor? {
        return UIColor.adjust(color, by: abs(percentage))
    }
    
    
    /// Darken the `color` in the gray-scale by the given precentage. for example, if you pass `UIColor.white` as the first argument, and darken it by `100` precent, you should get: `#000000` (`black` color).
    /// - Parameters:
    ///   - color: The `UIColor` to darken
    ///   - percentage: The precentage to darken the color with
    /// - Returns: The darkened color
    class func darken(_ color: UIColor, by percentage: CGFloat = 30.0) -> UIColor? {
        return UIColor.adjust(color, by: -1 * abs(percentage))
    }
    
    private class func adjust(_ color: UIColor, by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    final func lighten(by percentage: CGFloat = 30.0) -> UIColor? {
        return UIColor.adjust(self, by: percentage)
    }
    
    
    final func darken(by percentage: CGFloat = 30.0) -> UIColor? {
        return UIColor.adjust(self, by: -1 * percentage)
    }
}
