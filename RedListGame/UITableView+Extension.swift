import UIKit

extension UITableView {
    func register<T: TableViewRegistrable>(type: T.Type) {
        self.register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueCell<T: TableViewRegistrable>(indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("cell id is not matched")
        }
        return cell
    }
}

extension UITableViewCell: TableViewRegistrable { }

protocol TableViewRegistrable: class {
    static var reuseIdentifier: String { get }
}

extension TableViewRegistrable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
