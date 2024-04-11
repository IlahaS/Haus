import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let one, two, three, four: UInt64
        switch hex.count {
        case 3:
            (one, two, three, four) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (one, two, three, four) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (one, two, three, four) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (one, two, three, four) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(two) / 255, green: CGFloat(three)
                  / 255, blue: CGFloat(four) / 255, alpha: CGFloat(one) / 255)
    }
    static var mainBlueColor: UIColor { UIColor(hexString: "0066FF") }
    static var grayColor: UIColor {UIColor (hexString: "5E5E5E")}
    static var grayColor2: UIColor {UIColor (hexString: "EDEDED")}
    static var grayColor3: UIColor {UIColor (hexString: "7F7F7F")}
    static var grayColor4: UIColor {UIColor (hexString: "#D4D4D4")}
}
