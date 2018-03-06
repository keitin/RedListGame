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
    }
    
    func update(with timeLine: TimeLine) {
        var entries: [PieChartDataEntry] = []
        for user in timeLine.users {
            let value = timeLine.getCommentRate(user: user)
            let entry = PieChartDataEntry(value: value, label: user.name)
            entries.append(entry)
        }
        let pieChartSet = PieChartDataSet(values: entries, label: "Data")
        pieChartSet.setColors(.red, .orange, .blue)
        pieChartSet.valueFont = UIFont.systemFont(ofSize: 20)
        let pieChartData = PieChartData(dataSet: pieChartSet)
        pieChartView.data = pieChartData
    }
    
}
