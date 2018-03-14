import UIKit
import Foundation

extension UITableViewCell {
    func showBottomBorder(width: CGFloat) {
        let bottomBorderView = UIView()
        addSubview(bottomBorderView)
        bottomBorderView.backgroundColor = .lightGray
        bottomBorderView.leading(equalTo: self.leadingAnchor, constatnt: 20)
        bottomBorderView.trailing(equalTo: self.trailingAnchor, constatnt: 0)
        bottomBorderView.heightEqualTo(constant: width)
        bottomBorderView.bottom(equalTo: self.bottomAnchor, constatnt: 0)
    }
}
