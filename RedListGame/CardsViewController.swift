import UIKit

class CardsViewController: UIViewController {

    fileprivate var redList = RedList()
    fileprivate var collectionView: UICollectionView!
    fileprivate var isSelectedUser: Bool = false
    fileprivate let numberOfCols: CGFloat = 5
    fileprivate let numberOfRows: CGFloat = 3
    fileprivate var selectUserView: SelectUserView!
    
    private let selectUserViewHeight: CGFloat = 50.0
    private var longPressGesture : UILongPressGestureRecognizer!
    let participants = Participants(names: ["keita", "yo", "shio", "imamura"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let scoreViewController = ScoreViewController(redList: redList)
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
