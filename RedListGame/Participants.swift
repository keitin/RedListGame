import Foundation

class User {
    var id: Int
    var name: String
    var redList: RedList?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func isEqual(user: User) -> Bool {
        return self.id == user.id
    }
}
