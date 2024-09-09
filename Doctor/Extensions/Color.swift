//
//  Color.swift
//  Doctor
//
//  Created by Minh Nguỵn on 28/8/24.
//

import Foundation
import UIKit

// Extension to handle UIColor from hex string
extension UIColor {
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// Struct to define base colors
struct BaseColor {
    static let primaryColor = UIColor(hex: "#2C8667")
    static let secondaryColor = UIColor(hex: "#FF6347")
    // Add other colors as needed
}
