import Foundation
import UIKit

extension NSAttributedString {
    
    static func new(text: String, lineHeight: CGFloat) -> NSAttributedString {
        let lineHeight:CGFloat = 30.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
}
