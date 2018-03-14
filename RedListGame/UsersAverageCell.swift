import UIKit

class UsersAverageCell: UITableViewCell {

    @IBOutlet weak var averageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func update(with timeLine: TimeLine) {
        let average = timeLine.calculateUsersAverageScore()
        averageLabel.text = "\(timeLine.users.count)人の平均スコア: \(average)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
