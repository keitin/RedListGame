import UIKit

class IntroductionCell: UITableViewCell {

    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        titleLabel.text = "絶滅危惧種ゲーム"
        detailsLabel.text = "絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム絶滅危惧種ゲーム"
    }
    
    func update(with redList: RedList) {
        titleLabel.text = redList.title ?? "ゲーム"
        detailsLabel.attributedText = NSAttributedString.new(text: redList.introduction ?? "", lineHeight: 25)
        questionLabel.attributedText = NSAttributedString.new(text: redList.question ?? "", lineHeight: 25)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
