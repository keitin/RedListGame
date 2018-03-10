import UIKit

class AnimalCell: UITableViewCell {
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var animalNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
        selectionStyle = .none
    }
    
    func update(with animal: Animal, index: Int) {
        animalNameLabel.text = "\(index + 1)) \(animal.name)"
        hintLabel.text = animal.hint ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
