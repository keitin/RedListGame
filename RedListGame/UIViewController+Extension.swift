import UIKit
import Foundation

extension UIViewController {
    
    var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
}
