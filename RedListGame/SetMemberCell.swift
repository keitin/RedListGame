import UIKit

protocol SetMemberCellDelegate: class {
    func setMemberCell(setMemberCell: SetMemberCell, didTapAddUserButton userName: String)
}

class SetMemberCell: UITableViewCell {

    static let cellHeight: CGFloat = 133.0
    
    weak var delegate: SetMemberCellDelegate?
    
    @IBOutlet weak var addUserButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    @IBAction func didTapAddUserButton(_ sender: UIButton) {
        if let name = nameTextField.text {
            if name.isEmpty { return }
            delegate?.setMemberCell(setMemberCell: self, didTapAddUserButton: name)
            nameTextField.text = ""
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
