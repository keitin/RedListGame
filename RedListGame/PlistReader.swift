import Foundation
import UIKit

class PlistReader {
    
    private static let redListFileName = "RedList"
    private static let redListExtension = "plist"
    
    static func getRedList() -> [Animal] {
        guard let path = Bundle.main.path(forResource: redListFileName, ofType: "plist") else {
            fatalError("can not find plist: \(redListFileName)")
        }
        
        guard let dictArray = NSArray(contentsOfFile: path) else {
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
            
            let animal = Animal(order: order, name: name, image: image)
            animals.append(animal)
        }
        
        animals.sort { (animal1, animal2) -> Bool in
            return animal1.order < animal2.order
        }
        return animals
    }
    
}
