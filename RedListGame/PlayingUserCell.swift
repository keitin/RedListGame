import UIKit

class PlayingUserCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(with user: User?) {
        nameLabel.text = user?.name ?? "なし"
        nameLabel.textColor = (user == nil) ? .black : .white
        backgroundColor = (user == nil) ? .white : .mainColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
