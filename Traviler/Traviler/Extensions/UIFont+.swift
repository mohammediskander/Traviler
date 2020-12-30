//
//  UIFont+.swift
//  Todoiest
//
//  Created by Mohammed Iskandar on 08/12/2020.
//

import UIKit

struct AppFontName {
    static let black = "SF-Pro-Display-Black"
    static let blackItalic = "SF-Pro-Display-BlackItalic"
    static let bold = "SF-Pro-Display-Bold"
    static let boldItalic = "SF-Pro-Display-BoldItalic"
    static let heavy = "SF-Pro-Display-Heavy"
    static let heavyItalic = "SF-Pro-Display-HeavyItalic"
    static let light = "SF-Pro-Display-Light"
    static let lightItalig = "SF-Pro-Display-LightItalic"
    static let medium = "SF-Pro-Display-Medium"
    static let mediumItalic = "SF-Pro-Display-MediumItalic"
    static let regular = "SF-Pro-Display-Regular"
    static let regularItalic = "SF-Pro-Display-RegularItalic"
    static let semiBold = "SF-Pro-Display-Semibold"
    static let semiBoldItalic = "SF-Pro-Display-SemiboldItalic"
    static let thin = "SF-Pro-Display-Thin"
    static let thinItalic = "SF-Pro-Display-ThinItalic"
    static let ultralight = "SF-Pro-Display-Ultralight"
    static let ultralightItalic = "SF-Pro-Display-UltralightItalic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.regular
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }

        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
