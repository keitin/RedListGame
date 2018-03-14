import UIKit

class ExplainCell: UITableViewCell {

    @IBOutlet weak var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(with text: String) {
        explainLabel.attributedText = NSAttributedString.new(text: text, lineHeight: 30.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
