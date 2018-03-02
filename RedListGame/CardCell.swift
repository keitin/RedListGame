import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    func update(with animal: Animal, index: Int) {
        animalImageView.image = animal.image
        orderLabel.text = String(index + 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderLabel.textColor = .red
    }

}
