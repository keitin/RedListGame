import UIKit

class SynergyCell: UITableViewCell {

    @IBOutlet weak var synergyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(with timeLine: TimeLine) {
        let text = timeLine.isSynergyTeam ? "シナジーチーム" : "ディスシナジーチーム"
        synergyLabel.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
