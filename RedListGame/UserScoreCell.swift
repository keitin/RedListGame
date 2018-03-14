import UIKit

class UserScoreCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        showBottomBorder(width: 0.5)
    }
    
    func update(with user: User) {
        scoreLabel.text = "\(user.name): \(user.redList?.calculateScore() ?? 0)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
