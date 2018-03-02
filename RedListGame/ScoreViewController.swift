import UIKit

class ScoreViewController: UIViewController {

    fileprivate var redList: RedList
    private var tableView = UITableView()
    
    init(redList: RedList) {
        self.redList = redList
        redList.sortByCorrectOrder()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Score"
        tableView.frame = view.frame
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(type: ScoreCardCell.self)
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UITableViewDataSource

extension ScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redList.numerOfAnimals
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScoreCardCell = tableView.dequeueCell(indexPath: indexPath)
        let animal = redList.getAnimal(with: indexPath.row)
        cell.update(with: animal)
        return cell
    }
    
}
