import Foundation
import UIKit

class PlistReader {
    
    private static let redListFileName = "RedList"
    private static let redListExtension = "plist"
    
    static func getTitle() -> String? {
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dic = NSDictionary(contentsOfFile: path) else {
            fatalError("can not create array from \(path)")
        }
        
        return dic["gameTitle"] as? String
    }
    
    static func getIntroduction() -> String? {
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dic = NSDictionary(contentsOfFile: path) else {
            fatalError("can not create array from \(path)")
        }
        
        return dic["introduction"] as? String
    }
    
    static func getQuestion() -> String? {
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dic = NSDictionary(contentsOfFile: path) else {
            fatalError("can not create array from \(path)")
        }
        
        return dic["question"] as? String
    }
    
    static func getGameFlow() -> GameFlow {
        var gameFlow = GameFlow()
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dic = NSDictionary(contentsOfFile: path) else {
            fatalError("can not create array from \(path)")
        }
        
        guard let array = dic["gameFlow"] as? NSArray else {
            fatalError("can not create array from \(path)")
        }
        
        for flow in array {
            guard let f = flow as? String else {
                fatalError()
            }
            gameFlow.explanations.append(f)
        }
        return gameFlow
    }
    
    static func getAnimals() -> [Animal] {
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dic = NSDictionary(contentsOfFile: path) else {
            fatalError("can not create array from \(path)")
        }
        
        guard let dictArray = dic["animals"] as? NSArray else {
            fatalError("can not create array from \(path)")
        }
        
        var animals: [Animal] = []
        for item in dictArray {
            guard let dict = item as? NSDictionary else {
                fatalError("can not cast")
            }
            
            guard let name = dict["name"] as? String else {
                fatalError("can not cast name to String")
            }
            
            guard let imageName = dict["imageName"] as? String else {
                fatalError("can not cast iamgeName to String")
            }

            guard let image = UIImage(named: imageName) else {
                fatalError("can not create image from \(imageName)")
            }
            
            guard let orderStr = dict["order"] as? String, let order = Int(orderStr) else {
                fatalError("can not cast order to Int")
            }
            
            let hint = dict["hint"] as? String
            
            let animal = Animal(correctOrder: order, answerOrder: 0, name: name, image: image, hint: hint)
            animals.append(animal)
        }
        
        return animals
    }
    
}
