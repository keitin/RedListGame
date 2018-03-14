import UIKit

class ScoreViewController: UIViewController {

    fileprivate let timeLine: TimeLine
    fileprivate let redList: RedList?
    
    fileprivate enum LeftSection: Int {
        case scoreCard
        case lineChart
        case pieChart
        static let count = 3
    }
    
    fileprivate enum RightSection: Int {
        case finalScore
        case synergy
        case usersAverage
        case userScore
        static let count = 4
    }
    
    let leftTableView = UITableView()
    let rightTableView = UITableView()
    
    let leftTableViewTag = 1
    let rightTableViewTag = 2
    
    init(timeLine: TimeLine) {
        self.timeLine = timeLine
        self.redList = timeLine.getLatestRedList()
        redList?.sortByCorrectOrder()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(leftTableView)
        setTableView(tableView: leftTableView)
        leftTableView.leading(equalTo: view.leadingAnchor, constatnt: 0)
        leftTableView.widthEqualTo(constant: view.frame.width * 2 / 3 - 1.0)
        leftTableView.tag = leftTableViewTag
        leftTableView.register(type: ScoreCardCell.self)
        leftTableView.register(type: LineChartCell.self)
        leftTableView.register(type: PieChartCell.self)
        
        view.addSubview(rightTableView)
        setTableView(tableView: rightTableView)
        rightTableView.trailing(equalTo: view.trailingAnchor, constatnt: 0)
        rightTableView.widthEqualTo(constant: view.frame.width * 1 / 3 )
        rightTableView.tag = rightTableViewTag
        rightTableView.register(type: FinalScoreCell.self)
        rightTableView.register(type: SynergyCell.self)
        rightTableView.register(type: UsersAverageCell.self)
        rightTableView.register(type: UserScoreCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setTableView(tableView: UITableView) {
        tableView.top(equalTo: view.topAnchor, constatnt: 0)
        tableView.bottom(equalTo: view.bottomAnchor, constatnt: 0)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
}

// MARK: UITableViewDataSource

extension ScoreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == rightTableViewTag {
            return RightSection.count
        } else {
            return LeftSection.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == leftTableViewTag {
            guard let section = LeftSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .scoreCard:
                return redList?.numerOfAnimals ?? 0
            case .lineChart:
                return 1
            case .pieChart:
                return 1
            }
        } else {
            guard let section = RightSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .finalScore:
                return 1
            case .synergy:
                return 1
            case .usersAverage:
                return 1
            case .userScore:
                return timeLine.users.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == leftTableViewTag {
            guard let section = LeftSection.init(rawValue: indexPath.section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .scoreCard:
                let cell: ScoreCardCell = tableView.dequeueCell(indexPath: indexPath)
                let animal = redList!.getAnimal(with: indexPath.row)
                cell.update(with: animal)
                return cell
            case .lineChart:
                let cell: LineChartCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine)
                return cell
            case .pieChart:
                let cell: PieChartCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine)
                return cell
            }
        } else {
            guard let section = RightSection.init(rawValue: indexPath.section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .finalScore:
                let cell: FinalScoreCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine)
                return cell
            case .synergy:
                let cell: SynergyCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine)
                return cell
            case .usersAverage:
                let cell: UsersAverageCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine)
                return cell
            case .userScore:
                let cell: UserScoreCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: timeLine.users[indexPath.row])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == leftTableViewTag {
            guard let section = LeftSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .scoreCard:
                return "正解順位"
            case .lineChart:
                return "スコアの推移"
            case .pieChart:
                return "発言率"
            }
        } else {
            guard let section = RightSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .finalScore:
                return "あなたのスコア"
            case .synergy:
                return "あなたのチーム"
            case .usersAverage:
                return "チームの個人平均"
            case .userScore:
                return "個人のスコア"
            }
        }
    }
}

