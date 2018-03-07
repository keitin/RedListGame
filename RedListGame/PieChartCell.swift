import UIKit
import Charts

class PieChartCell: UITableViewCell {

    let pieChartView = PieChartView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        addSubview(pieChartView)
        pieChartView.pinTo(superView: self, constant: 0)
        pieChartView.isUserInteractionEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.legend.enabled = false
    }
    
    func update(with timeLine: TimeLine) {
        var entries: [PieChartDataEntry] = []
        for user in timeLine.users {
            let value = timeLine.getCommentRate(user: user)
            let numberOfGoodComments = timeLine.getNumberOfGoodComments(user: user)
            let numberOfBadCommnets = timeLine.getNumberOfBadComments(user: user)
            let text = "\(user.name)\nGood comments: \(numberOfGoodComments)\nBad comments: \(numberOfBadCommnets)"
            let entry = PieChartDataEntry(value: value, label: text)
            entries.append(entry)
        }
        let pieChartSet = PieChartDataSet(values: entries, label: "Data")
        pieChartSet.setColors(.red, .orange, .blue)
        pieChartSet.valueFont = UIFont.systemFont(ofSize: 20)
        let pieChartData = PieChartData(dataSet: pieChartSet)
        pieChartView.data = pieChartData
        pieChartSet.entryLabelColor = .black
    }
    
}
