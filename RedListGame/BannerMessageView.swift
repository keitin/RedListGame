import UIKit

class BannerMessageView: UILabel {

    private let height: CGFloat = 50.0
    
    func show(superView: UIView, with message: String) {
        frame.size.width = superView.frame.width
        frame.size.height = height
        frame.origin.x = 0
        frame.origin.y = -height
        text = message
        backgroundColor = .red
        textAlignment = .center
        textColor = .white
        superView.addSubview(self)
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.frame.origin.y = 0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hide()
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = -self.height
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
