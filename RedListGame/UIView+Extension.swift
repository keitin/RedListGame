import UIKit
import Foundation


extension UIView {
    
    func pinTo(superView: UIView, constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: constant).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
    }
    
}
