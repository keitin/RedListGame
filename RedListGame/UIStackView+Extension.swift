import UIKit
import Foundation

extension UIStackView {
    
    func fillEquallyHorizontal(spacing: CGFloat) {
        axis = .horizontal
        alignment = .center
        distribution = .fillEqually
        self.spacing = spacing
    }
    
}
