import UIKit

protocol UserNameCellDelegate: class {
    func userNameCell(userNameCell: UserNameCell, didTapStartButton index: Int)
}

class UserNameCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    private var index: Int!
    
    weak var delegate: UserNameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        startButton.backgroundColor = .lightGray
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 5.0
        
        showBottomBorder(width: 0.5)
    }
    
    func update(with user: User, index: Int, isHiddenButton: Bool) {
        let name = (user.redList != nil && !isHiddenButton) ? "\(user.name) : 入力済み" : user.name
        nameLabel.text = name
        self.index = index
        startButton.isHidden = isHiddenButton
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapStartButton(_ sender: UIButton) {
        delegate?.userNameCell(userNameCell: self, didTapStartButton: index)
    }
}
