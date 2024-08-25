import UIKit

struct BaseColor {
    static let primaryColor = UIColor(hex: "#2C8667")
    static let secondaryColor = UIColor(hex: "#FF6347") // Ví dụ thêm màu khác
    // Bạn có thể thêm các màu khác nếu cần
}

// Extension to handle UIColor from hex string
extension UIColor {
    convenience init(hex: String) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = CGFloat(Int(color >> 16) & mask) / 255.0
        let g = CGFloat(Int(color >> 8) & mask) / 255.0
        let b = CGFloat(Int(color) & mask) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
