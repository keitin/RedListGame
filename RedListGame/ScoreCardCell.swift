import UIKit

class ScoreCardCell: UITableViewCell {

    private let animalNameLabel = UILabel()
    private let correctLabel = UILabel()
    private let answerLabel = UILabel()
    private let memoLabel = UILabel()
    
    private let itemMargin: CGFloat = 12.0
    private let itemVerticalMargin: CGFloat = 2.0
    private let numberOfItems: CGFloat = 4.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none        
        let itemWidth = (UIApplication.shared.keyWindow?.frame.width)! / numberOfItems
        
        addSubview(animalNameLabel)
        animalNameLabel.numberOfLines = 0
        animalNameLabel.widthEqualTo(constant: itemWidth)
        animalNameLabel.top(equalTo: self.topAnchor, constatnt: itemVerticalMargin)
        animalNameLabel.bottom(equalTo: self.bottomAnchor, constatnt: itemVerticalMargin)
        animalNameLabel.leading(equalTo: self.leadingAnchor, constatnt: itemMargin)
        
        addSubview(correctLabel)
        correctLabel.numberOfLines = 0
        correctLabel.widthEqualTo(constant: itemWidth)
        correctLabel.top(equalTo: self.topAnchor, constatnt: itemVerticalMargin)
        correctLabel.bottom(equalTo: self.bottomAnchor, constatnt: itemVerticalMargin)
        correctLabel.leading(equalTo: animalNameLabel.trailingAnchor, constatnt: itemMargin)
    
        addSubview(answerLabel)
        answerLabel.numberOfLines = 0
        answerLabel.widthEqualTo(constant: itemWidth)
        answerLabel.top(equalTo: self.topAnchor, constatnt: itemVerticalMargin)
        answerLabel.bottom(equalTo: self.bottomAnchor, constatnt: itemVerticalMargin)
        answerLabel.leading(equalTo: correctLabel.trailingAnchor, constatnt: itemMargin)
        
        addSubview(memoLabel)
        memoLabel.numberOfLines = 0
        memoLabel.widthEqualTo(constant: itemWidth)
        memoLabel.top(equalTo: self.topAnchor, constatnt: itemVerticalMargin)
        memoLabel.bottom(equalTo: self.bottomAnchor, constatnt: itemVerticalMargin)
        memoLabel.leading(equalTo: answerLabel.trailingAnchor, constatnt: itemMargin)
        
    }
    
    func update(with animal: Animal) {
        animalNameLabel.text = animal.name
        correctLabel.text = "正解: \(animal.correctOrder)"
        answerLabel.text = "あなたの解答: \(animal.answerOrder)"
        memoLabel.text = "メモメモ"
    }

    
}
