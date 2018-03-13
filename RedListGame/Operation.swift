import Foundation

class TimeLine {
    var operations: [Operation] = []
    var users: [User]
    var numberOfUsers: Int { return users.count }
    var numberOfOperations: Int { return operations.count }
    var initialScore: Int
    
    init(users: [User], initialScore: Int) {
        self.users = users
        self.initialScore = initialScore
    }
    
    func append(operation: Operation) {
        operations.append(operation)
    }
    
    func getLatestScore() -> Int {
        return operations.last?.redList.calculateScore() ?? 0
    }
    
    func getLatestRedList() -> RedList? {
        return operations.last?.redList
    }
    
    func getCommentRate(user: User) -> Double {
        return Double(calculateNumberOfComments(user: user)) / Double(numberOfOperations) * 100
    }
    
    func getNumberOfGoodComments(user: User) -> Int {
        var count = 0
        var prevScore = initialScore
        for operation in operations {
            let currScore = operation.redList.calculateScore()
            if operation.user.isEqual(user: user) && currScore < prevScore {
                count = count + 1
            }
            prevScore = currScore
        }
        return count
    }
    
    func getNumberOfBadComments(user: User) -> Int {
        var count = 0
        var prevScore = initialScore
        for operation in operations {
            let currScore = operation.redList.calculateScore()
            if operation.user.isEqual(user: user) && currScore >= prevScore {
                count = count + 1
            }
            prevScore = currScore
        }
        return count
    }
    
    private func calculateNumberOfComments(user: User) -> Int {
        var count = 0
        for operation in operations {
            if user.id == operation.user.id {
                count = count + 1
            }
        }
        return count
    }
}

struct Operation {
    var user: User
    var time: Int
    var redList: RedList
    var hand: Hand
}

struct Hand {
    var animal: Animal
    var fromId: Int
    var toId: Int
}
