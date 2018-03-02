import UIKit

extension UICollectionView {
    func register<T: Registrable>(type: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCell<T: Registrable>(indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("cell id is not matched")
        }
        return cell
    }
}

extension UICollectionViewCell: Registrable { }

protocol Registrable: class {
    static var reuseIdentifier: String { get }
}

extension Registrable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
