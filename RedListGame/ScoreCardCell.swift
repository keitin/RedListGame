import UIKit

class ScoreCardCell: UITableViewCell {

    private let animalNameLabel = UILabel()
    private let correctLabel = UILabel()
    private let answerLabel = UILabel()
    private let memoLabel = UILabel()
    private let diffLabel = UILabel()
    private let bottomBorderView = UIView()
    
    private let itemMargin: CGFloat = 20.0
    private let itemVerticalMargin: CGFloat = 2.0
    private let numberOfItems: CGFloat = 5.0
    private let borderWidth: CGFloat = 0.5
    private var minCellHight: CGFloat {
        return ((UIApplication.shared.keyWindow?.frame.height)! - 60.0) / 15.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        let itemWidth = (UIApplication.shared.keyWindow?.frame.width)! / numberOfItems
        
        addSubview(animalNameLabel)
        setCommonAutoLayout(view: animalNameLabel)
        animalNameLabel.widthEqualTo(constant: itemWidth)
        animalNameLabel.leading(equalTo: self.leadingAnchor, constatnt: itemMargin)
        
        addSubview(correctLabel)
        setCommonAutoLayout(view: correctLabel)
        correctLabel.widthEqualTo(constant: itemWidth / 2.0)
        correctLabel.leading(equalTo: animalNameLabel.trailingAnchor, constatnt: itemMargin)
        
        addSubview(answerLabel)
        setCommonAutoLayout(view: answerLabel)
        answerLabel.widthEqualTo(constant: itemWidth)
        answerLabel.leading(equalTo: correctLabel.trailingAnchor, constatnt: itemMargin)
        
        addSubview(diffLabel)
        diffLabel.textColor = .red
        setCommonAutoLayout(view: diffLabel)
        diffLabel.widthEqualTo(constant: itemWidth / 2.0)
        diffLabel.leading(equalTo: answerLabel.trailingAnchor, constatnt: itemMargin)
        
        addSubview(memoLabel)
        setCommonAutoLayout(view: memoLabel)
        memoLabel.leading(equalTo: diffLabel.trailingAnchor, constatnt: itemMargin)
        memoLabel.trailing(equalTo: self.trailingAnchor, constatnt: itemMargin)
        
        addSubview(bottomBorderView)
        bottomBorderView.backgroundColor = .lightGray
        bottomBorderView.leading(equalTo: self.leadingAnchor, constatnt: 20)
        bottomBorderView.trailing(equalTo: self.trailingAnchor, constatnt: 0)
        bottomBorderView.heightEqualTo(constant: borderWidth)
        bottomBorderView.bottom(equalTo: self.bottomAnchor, constatnt: 0)
        
    }
    
    func update(with animal: Animal) {
        animalNameLabel.text = animal.name
        correctLabel.text = "正解: \(animal.correctOrder)"
        answerLabel.text = "あなたの解答: \(animal.answerOrder)"
        diffLabel.text = "差: \(abs(animal.correctOrder - animal.answerOrder))"
        memoLabel.text = "卵生　1回/2300"
    }
    
    func setCommonAutoLayout(view: UILabel) {
        view.numberOfLines = 0
        view.top(equalTo: self.topAnchor, constatnt: itemVerticalMargin)
        view.bottom(equalTo: self.bottomAnchor, constatnt: itemVerticalMargin)
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: minCellHight).isActive = true
    }
}

