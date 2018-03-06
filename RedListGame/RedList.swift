import UIKit
import Foundation

class RedList {
    
    var numerOfAnimals: Int {
        return animals.count
    }
    
    private var animals: [Animal] = []
    
    init() {
        self.animals = PlistReader.getRedList()
        shuffle()
        updateAnserOrder()
    }
    
    func getAnimal(with index: Int) -> Animal {
        return animals[index]
    }
    
    func calculateScore() -> Int {
        var total = 0
        for animal in animals {
            total = total + abs(animal.answerOrder - animal.correctOrder)
        }
        return total
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
        updateAnserOrder()
    }
    
    func updateAnserOrder() {
        for i in 0 ..< animals.count {
            let animal = animals[i]
            animal.answerOrder = i + 1
        } 
    }
    
    func sortByCorrectOrder() {
        animals.sort { (animal1, animal2) -> Bool in
            return animal1.correctOrder < animal2.correctOrder
        }
    }
    
    func sortByAnswerOrder() {
        animals.sort { (animal1, animal2) -> Bool in
            return animal1.answerOrder < animal2.answerOrder
        }
    }
    
    func shuffle() {
        var index = animals.count
        while index > 1 {
            let newIndex = Int(arc4random_uniform(UInt32(index)))
            index = index - 1
            if index != newIndex {
                swap(&animals[index], &animals[newIndex])
            }
        }
    }
    
    func copy() -> RedList {
        let copyedRedList = RedList()
        var newAnimals: [Animal] = []
        for a in animals {
            let animal = Animal(correctOrder: a.correctOrder, answerOrder: a.answerOrder, name: a.name, image: a.image)
            newAnimals.append(animal)
        }
        copyedRedList.animals = newAnimals
        return copyedRedList
    }
    
}

class Animal {
    var correctOrder: Int
    var answerOrder: Int
    var name: String
    var image: UIImage
    
    init(correctOrder: Int, answerOrder: Int, name: String, image: UIImage) {
        self.correctOrder = correctOrder
        self.answerOrder = answerOrder
        self.name = name
        self.image = image
    }
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

