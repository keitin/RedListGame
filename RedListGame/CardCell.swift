import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    func update(with animal: Animal, index: Int) {
        animalImageView.image = animal.image
        orderLabel.text = String(index + 1)
        hintLabel.text = animal.hint ?? ""
        nameLabel.text = animal.name
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderLabel.textColor = .mainColor
        backgroundColor = .white
    }

}
