import UIKit
import Charts

class LineChartCell: UITableViewCell {

    private let chartMargin: CGFloat = 20.0
    private let lineChartView = LineChartView()
    fileprivate weak var timeLine: TimeLine!
    let cellHeight: CGFloat = 400.0
    let margin: CGFloat = 20.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        addSubview(lineChartView)
        lineChartView.heightEqualTo(constant: cellHeight)
        lineChartView.pinTo(superView: self, constant: 0)
        lineChartView.legend.enabled = false
        lineChartView.extraLeftOffset = margin
        lineChartView.extraRightOffset = margin
        lineChartView.extraTopOffset = margin
        lineChartView.extraBottomOffset = margin
    }
    
    func update(with timeLine: TimeLine) {
        self.timeLine = timeLine
        var entries: [BarChartDataEntry] = []
        let initialEntry = BarChartDataEntry(x: 0, y: Double(timeLine.initialScore), data: User(id: Int.max, name: "start") as AnyObject)
        entries.append(initialEntry)
        for operation in timeLine.operations {
            let time = Double(operation.time)
            let score = Double(operation.redList.calculateScore())
            let entry = BarChartDataEntry(x: time, y: score, data: operation.user as AnyObject)
            entries.append(entry)
        }
        let lineChartSet = LineChartDataSet(values: entries, label: "Data")
        lineChartSet.valueFont = UIFont.systemFont(ofSize: 20)
        let lineChartData = LineChartData(dataSet: lineChartSet)
        lineChartData.setValueFormatter(self)
        lineChartView.data = lineChartData
    }
}

// MARK: IValueFormatter

extension LineChartCell: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let user = entry.data as! User
        return user.name + "\n" + String(value)
    }
}
