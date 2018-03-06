import UIKit

class CardsViewController: UIViewController {

    fileprivate var redList = RedList()
    fileprivate var collectionView: UICollectionView!
    fileprivate var isSelectedUser: Bool = false
    fileprivate let numberOfCols: CGFloat = 5
    fileprivate let numberOfRows: CGFloat = 3
    fileprivate var selectUserView: SelectUserView!
    fileprivate var selectedUser: User?
    fileprivate var currentTime: Int = 0
    fileprivate var timer: Timer!
    
    private let selectUserViewHeight: CGFloat = 50.0
    private var longPressGesture : UILongPressGestureRecognizer!
    let participants = Participants(names: ["keita", "yo", "shio"])
    
    fileprivate var timeLine: TimeLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLine = TimeLine(users: participants.getUsers())
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        let collectionViewHeight = view.frame.height - navigationBarHeight - selectUserViewHeight - statusBarHeight
        collectionView.frame.size.height = collectionViewHeight
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(type: CardCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let selectUserViewY = view.frame.height - selectUserViewHeight - navigationBarHeight - statusBarHeight
        let frame = CGRect(x: 0, y: selectUserViewY, width: view.frame.width, height: selectUserViewHeight)
        selectUserView = SelectUserView(frame: frame)
        selectUserView.set(with: participants)
        selectUserView.delegate = self
        view.addSubview(selectUserView)
        
        longPressGesture = UILongPressGestureRecognizer(
            target: self, action: #selector(CardsViewController.handleLongGesture(gesture:))
        )
        collectionView.addGestureRecognizer(longPressGesture)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.currentTime = self.currentTime + 1
            self.title = "時間： \(self.currentTime)"
        })
        timer.fire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        redList.sortByAnswerOrder()
        
        let toScoreButton = UIBarButtonItem(title: "採点する", style: .done, target: self, action: #selector(CardsViewController.didTapToScoreButton(sender:)))
        navigationItem.rightBarButtonItem = toScoreButton
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            if !isSelectedUser {
                BannerMessageView().show(superView: self.view, with: "ユーザを選んでください")
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
            collectionView.reloadData()
            selectUserView.clearSelectButtons()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
        isSelectedUser = false
    }
    
    func didTapToScoreButton(sender: UIBarButtonItem) {
        timer.invalidate()
        let scoreViewController = ScoreViewController(timeLine: timeLine)
        navigationController?.pushViewController(scoreViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UserSelectViewDelegate 

extension CardsViewController: SelectUserViewDelegate {
    func selectUserView(selectUserView: SelectUserView, didTapUserButton user: User) {
        print(user.name)
        isSelectedUser = true
        selectedUser = user
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
        
        if let user = selectedUser {
            let targetAnimal = redList.getAnimal(with: sourceIndexPath.row)
            let hand = Hand(animal: targetAnimal, fromId: sourceIndexPath.row, toId: destinationIndexPath.row)
            let operation = Operation(user: user, time: currentTime, redList: redList.copy(), hand: hand)
            timeLine.append(operation: operation)
            print(operation)
            print(targetAnimal.name)
        }
        
        redList.move(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
}

// MARK : UICollectionViewDelegateFlowLayout

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / numberOfCols - numberOfCols
        let height = collectionView.frame.height / numberOfRows - numberOfRows
        return CGSize(width: width, height: height)
    }
    
}
