import Foundation

class Participants {
    
    private var users: [User] = []
    var count: Int { return users.count }
    
    init(names: [String]) {
        var id = 0;
        for name in names {
            let user = User(id: id, name: name)
            users.append(user)
            id = id + 1
        }
    }
    
    func getUsers() -> [User] {
        return users
    }
}

struct User {
    var id: Int
    var name: String
}
