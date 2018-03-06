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
    
    func widthEqualTo(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func heightEqualTo(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func leading(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constatnt: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: equalTo, constant: constatnt).isActive = true
    }
    
    func trailing(equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>, constatnt: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: equalTo, constant: constatnt).isActive = true
    }
    
    func top(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constatnt: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: equalTo, constant: constatnt).isActive = true
    }
    
    func bottom(equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>, constatnt: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: equalTo, constant: constatnt).isActive = true
    }
}
