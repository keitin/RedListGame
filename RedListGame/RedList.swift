import UIKit
import Foundation

class RedList {
    
    var numerOfAnimals: Int {
        return animals.count
    }
    
    private var animals: [Animal] = []
    
    init() {
        self.animals = PlistReader.getRedList()
    }
    
    func getAnimal(with index: Int) -> Animal {
        return animals[index]
    }
    
    func move(fromIndex: Int, toIndex: Int) {
        var copyArr: [Animal] = animals.copy()
        animals[toIndex] = copyArr[fromIndex]
        if fromIndex < toIndex {
            for i in fromIndex ..< toIndex {
                animals[i] = copyArr[i + 1]
            }
        } else {
            for i in toIndex ..< fromIndex {
                animals[i + 1] = copyArr[i]
            }
        }
    }
    
}

struct Animal {
    var order: Int
    var name: String
    var image: UIImage
}

extension Array {
    func copy<T>() -> [T] {
        var copyArr: [T] = []
        for item in self {
            copyArr.append(item as! T)
        }
        return copyArr
    }
}
