import UIKit

class GameFlowCell: UITableViewCell {

    @IBOutlet weak var flowLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(with string: String, index: Int) {
        flowLabel.text = string
        orderLabel.text = String(index + 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
