//
//  UIColor+ApplicationTheme.swift
//  Traviler
//
//  Created by Mohammed Iskandar on 19/12/2020.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static var goldColor: UIColor = UIColor(hex: "#FFCC00")!
        public static var secondayColor: UIColor = .systemGray
        public static var disabledColor: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.darken(.systemGray, by: 20)!
                } else {
                    /// Return the color for Light Mode
                    return UIColor.lighten(.systemGray, by: 20)!
                }
            }
        }()
        public static var secondaryBackgroundColor: UIColor = {
//            "#F2F2F2"
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor(hex: "#F2F2F2")!.darken(by: 80)!
                } else {
                    /// Return the color for Light Mode
                    return UIColor(hex: "#F2F2F2")!
                }
            }
        }()
        public static var backgroundColor: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.darken(.white, by: 80)!
                } else {
                    /// Return the color for Light Mode
                    return UIColor.lighten(.white, by: 80)!
                }
            }
        }()
        public static var captionColor: UIColor = {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.darken(.systemGray, by: 60)!
                } else {
                    /// Return the color for Light Mode
                    return UIColor.lighten(.systemGray, by: 30)!
                }
            }
        }()
    }
}


/// Shared style object, to be used anywhere in the project
public let Style = DefaultStyle.self
