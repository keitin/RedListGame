import UIKit
import Charts

class AnalysisViewController: UIViewController {

    fileprivate let timeLine: TimeLine
    fileprivate enum Section: Int {
        case lineChart
        case pieChart
        static let count = 2
    }
    
    private let tableView = UITableView()
    
    init(timeLine: TimeLine) {
        self.timeLine = timeLine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.frame
        tableView.frame.size.height = view.frame.height - navigationBarHeight - statusBarHeight
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(type: LineChartCell.self)
        tableView.register(type: PieChartCell.self)
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UITableViewDataSource

extension AnalysisViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section.init(rawValue: indexPath.section) else {
            fatalError("Invalid section number")
        }
        switch section {
        case .lineChart:
            let cell: LineChartCell = tableView.dequeueCell(indexPath: indexPath)
            cell.update(with: timeLine)
            return cell
        case .pieChart:
            let cell: PieChartCell = tableView.dequeueCell(indexPath: indexPath)
            cell.update(with: timeLine)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section.init(rawValue: section) else {
            fatalError("Invalid section number")
        }
        switch section {
        case .lineChart:
            return "スコアの推移"
        case .pieChart:
            return "発言率"
        }
    }
}


// MARK: UITableViewDelegate

extension AnalysisViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height - statusBarHeight
    }
}
