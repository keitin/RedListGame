import UIKit

class CardsViewController: UIViewController {

    fileprivate var collectionView: UICollectionView!
    fileprivate let tableView = UITableView()
    
    fileprivate var redList: RedList
    fileprivate let numberOfCols: CGFloat = 5
    fileprivate let numberOfRows: CGFloat = 3
    fileprivate var selectedUser: User?
    fileprivate var currentTime: Int = 0
    fileprivate var timer: Timer!
    
    private let selectUserViewHeight: CGFloat = 50.0
    private var longPressGesture : UILongPressGestureRecognizer!
    var users: [User]
    var setTime: Int
    var user: User?
    var isTeam: Bool {
        return user == nil
    }
    
    fileprivate var timeLine: TimeLine!
    
    init(users: [User], setTime: Int, user: User?) {
        self.users = users
        self.setTime = setTime
        self.user = user
        self.redList = user?.redList ?? RedList()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum TableSection: Int {
        case restTime
        case playingUser
        case users
        case explanation
        
        static let count = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        timeLine = TimeLine(users: users, initialScore: redList.calculateScore())
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.widthEqualTo(constant: view.frame.width * 3 / 4 - 1.0)
        collectionView.top(equalTo: view.topAnchor, constatnt: 0)
        collectionView.bottom(equalTo: view.bottomAnchor, constatnt: 0)
        collectionView.leading(equalTo: view.leadingAnchor, constatnt: 0)
        collectionView.backgroundColor = .white
        collectionView.register(type: CardCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(tableView)
        tableView.widthEqualTo(constant: view.frame.width * 1 / 4)
        tableView.trailing(equalTo: view.trailingAnchor, constatnt: 0)
        tableView.top(equalTo: view.topAnchor, constatnt: 0)
        tableView.bottom(equalTo: view.bottomAnchor, constatnt: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(type: UserNameCell.self)
        tableView.register(type: RestTimeCell.self)
        tableView.register(type: PlayingUserCell.self)
        tableView.register(type: ExplainCell.self)
        
        longPressGesture = UILongPressGestureRecognizer(
            target: self, action: #selector(CardsViewController.handleLongGesture(gesture:))
        )
        collectionView.addGestureRecognizer(longPressGesture)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.currentTime = self.currentTime + 1
            self.title = "時間： \(self.currentTime)"
            self.tableView.reloadData()
        })
        timer.fire()
        
        print("score: \(redList.calculateScore())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        redList.sortByAnswerOrder()
        
        let toScoreButton = UIBarButtonItem(title: "採点する", style: .done, target: self, action: #selector(CardsViewController.didTapToScoreButton(sender:)))
        let confirmButton = UIBarButtonItem(title: "確定", style: .done, target: self, action: #selector(CardsViewController.didTapConfirmButton(sender:)))
        
        navigationItem.rightBarButtonItem = isTeam ? toScoreButton : confirmButton
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            if selectedUser == nil && isTeam {
                BannerMessageView().show(superView: self.view, with: "ユーザを選んでください")
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
            print("score: \(redList.calculateScore())")
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func didTapToScoreButton(sender: UIBarButtonItem) {
        timer.invalidate()
        let scoreViewController = ScoreViewController(timeLine: timeLine)
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
    
    func didTapConfirmButton(sender: UIBarButtonItem) {
        user?.redList = redList.copy()
        dismiss(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK : UICollectionViewDataSource

extension CardsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return redList.numerOfAnimals
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCell = collectionView.dequeueCell(indexPath: indexPath)
        let animal = redList.getAnimal(with: indexPath.row)
        cell.update(with: animal, index: indexPath.row)
        return cell
    }
}

// MARK : UICollectionViewDelegate

extension CardsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        redList.move(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        if let user = selectedUser {
            let targetAnimal = redList.getAnimal(with: sourceIndexPath.row)
            let hand = Hand(animal: targetAnimal, fromId: sourceIndexPath.row, toId: destinationIndexPath.row)
            let operation = Operation(user: user, time: currentTime, redList: redList.copy(), hand: hand)
            timeLine.append(operation: operation)
            print(operation)
            print(targetAnimal.name)
        }
        selectedUser = nil
        tableView.reloadData()
    }
    
}

// MARK : UICollectionViewDelegateFlowLayout

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / numberOfCols
        let height = collectionView.frame.height / numberOfRows
        return CGSize(width: width, height: height)
    }
    
}

// MARK: UITableViewDataSource

extension CardsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = TableSection.init(rawValue: section) else {
            fatalError("Invalid section")
        }
        switch section {
        case .restTime:
            return 1
        case .playingUser:
            return 1
        case .users:
            return isTeam ? timeLine.users.count : 0
        case .explanation:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = TableSection.init(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }
        switch section {
        case .restTime:
            let cell: RestTimeCell = tableView.dequeueCell(indexPath: indexPath)
            cell.update(with: setTime - currentTime)
            return cell
        case .playingUser:
            let cell: PlayingUserCell = tableView.dequeueCell(indexPath: indexPath)
            cell.update(with: isTeam ? selectedUser : user)
            return cell
        case .users:
            let cell: UserNameCell = tableView.dequeueCell(indexPath: indexPath)
            cell.update(with: timeLine.users[indexPath.row], index: indexPath.row, isHiddenButton: true)
            return cell
        case .explanation:
            let cell: ExplainCell = tableView.dequeueCell(indexPath: indexPath)
            if isTeam {
                cell.update(with: "操作するユーザを選択し、カードを長押しすることでカードを移動することができます")
            } else {
                cell.update(with: "カードを長押しすることでカードを移動することができます")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = TableSection.init(rawValue: section) else {
            fatalError("Invalid section")
        }
        switch section {
        case .restTime:
            return "残り時間"
        case .playingUser:
            return "操作中のユーザ"
        case .users:
            return isTeam ? "操作するユーザを選択" : nil
        case .explanation:
            return "操作方法"
        }
    }
}

extension CardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = TableSection.init(rawValue: indexPath.section) else {
            fatalError("Invalid section")
        }
        if section == .users {
            selectedUser = timeLine.users[indexPath.row]
            tableView.reloadData()
        }
    }
}
