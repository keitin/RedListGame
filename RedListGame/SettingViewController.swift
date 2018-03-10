import UIKit

class SettingViewController: UIViewController {

    let redList = RedList()
    let leftTableView = UITableView()
    let rightTableView = UITableView()
    
    let leftTableViewTag = 1
    let rightTableViewTag = 2
    
    var userNames: [String] = []
    var setTimeCell: SetTimeCell!
    
    fileprivate enum LeftSection: Int {
        case introduction
        case gameFlow
        case animals
        static let count = 3
    }
    
    fileprivate enum RightSection: Int {
        case setMember
        case userName
        case setTime
        case startGame
        static let count = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(leftTableView)
        setTableView(tableView: leftTableView)
        leftTableView.leading(equalTo: view.leadingAnchor, constatnt: 0)
        leftTableView.widthEqualTo(constant: view.frame.width * 2 / 3 - 1.0)
        leftTableView.tag = leftTableViewTag
        leftTableView.register(type: IntroductionCell.self)
        leftTableView.register(type: GameFlowCell.self)
        leftTableView.register(type: AnimalCell.self)
        
        view.addSubview(rightTableView)
        setTableView(tableView: rightTableView)
        rightTableView.trailing(equalTo: view.trailingAnchor, constatnt: 0)
        rightTableView.widthEqualTo(constant: view.frame.width * 1 / 3 )
        rightTableView.tag = rightTableViewTag
        rightTableView.register(type: SetTimeCell.self)
        rightTableView.register(type: SetMemberCell.self)
        rightTableView.register(type: UserNameCell.self)
        rightTableView.register(type: StartGameCell.self)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.didTapScreen(sender:)))
        view.addGestureRecognizer(gesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapScreen(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func setTableView(tableView: UITableView) {
        tableView.top(equalTo: view.topAnchor, constatnt: 0)
        tableView.bottom(equalTo: view.bottomAnchor, constatnt: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
}

// MARK: UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == leftTableViewTag {
            return LeftSection.count
        } else {
            return RightSection.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == leftTableViewTag {
            guard let section = LeftSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .introduction:
                return 1
            case .gameFlow:
                return redList.gameFlow.explanations.count
            case .animals:
                return redList.numerOfAnimals
            }
        } else {
            guard let section = RightSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .setTime:
                return 1
            case .setMember:
                return 1
            case .userName:
                return userNames.count
            case .startGame:
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == leftTableViewTag {
            guard let section = LeftSection.init(rawValue: indexPath.section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .introduction:
                let cell: IntroductionCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: redList)
                return cell
            case .gameFlow:
                let cell: GameFlowCell = tableView.dequeueCell(indexPath: indexPath)
                let explanation = redList.gameFlow.explanations[indexPath.row]
                cell.update(with: explanation, index: indexPath.row)
                return cell
            case .animals:
                let cell: AnimalCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: redList.getAnimal(with: indexPath.row), index: indexPath.row)
                return cell
            }
        } else {
            guard let section = RightSection.init(rawValue: indexPath.section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .setTime:
                let cell: SetTimeCell = tableView.dequeueCell(indexPath: indexPath)
                self.setTimeCell = cell
                return cell
            case .setMember:
                let cell: SetMemberCell = tableView.dequeueCell(indexPath: indexPath)
                cell.delegate = self
                return cell
            case .userName:
                let cell: UserNameCell = tableView.dequeueCell(indexPath: indexPath)
                cell.update(with: userNames[indexPath.row])
                return cell
            case .startGame:
                let cell: StartGameCell = tableView.dequeueCell(indexPath: indexPath)
                cell.delegate = self
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.tag == rightTableViewTag {
            guard let section = RightSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .setTime:
                return "時間の設定"
            case .setMember:
                return "メンバーの設定"
            case .userName:
                return "参加メンバー \(userNames.count)人"
            default:
                return nil
            }
        } else {
            guard let section = LeftSection.init(rawValue: section) else {
                fatalError("Invalid section")
            }
            switch section {
            case .introduction:
                return "ゲームの概要"
            case .gameFlow:
                return "ゲームの流れ"
            case .animals:
                return "並び替える動物の種類"
            }
        }
    }
}

// MARK: UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

// MARK: SetMemberCellDelegate

extension SettingViewController: SetMemberCellDelegate {
    func setMemberCell(setMemberCell: SetMemberCell, didTapAddUserButton userName: String) {
        userNames.append(userName)
        rightTableView.reloadData()
    }
}

// MARK: StartGameCellDelegate

extension SettingViewController: StartGameCellDelegate {
    func didTapStartGameButton(startGameCell: StartGameCell) {
        if userNames.isEmpty {
            BannerMessageView().show(superView: self.view, with: "ユーザを追加してください")
            return
        }
        let setTime = setTimeCell.selectedTime
        let cardsViewController = CardsViewController(names: userNames, setTime: setTime)
        navigationController?.pushViewController(cardsViewController, animated: true)
    }
}
