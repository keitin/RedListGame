import UIKit

protocol StartGameCellDelegate: class {
    func didTapStartGameButton(startGameCell: StartGameCell)
}

class StartGameCell: UITableViewCell {

    @IBOutlet weak var startButton: UIButton!
    
    weak var delegate: StartGameCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startButton.backgroundColor = .mainColor
        startButton.setTitleColor(.white, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTapStartGameButton(_ sender: UIButton) {
        delegate?.didTapStartGameButton(startGameCell: self)
    }
}
