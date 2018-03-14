import UIKit

extension UIApplication {
    
    static func changeRootViewController(viewController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    static func setInitialVCWithNC(controller: UIViewController, title: String) {
        let navigationController = UINavigationController(rootViewController: controller)
        UINavigationBar.appearance().isTranslucent = false
        controller.title = title
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
}
