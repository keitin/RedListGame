import UIKit

class ScoreViewController: UIViewController {

    fileprivate let timeLine: TimeLine
    fileprivate let redList: RedList?
    private var tableView = UITableView()
    
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

        title = "今回のスコア: \(timeLine.getLatestScore())"
        tableView.frame = view.frame
        tableView.frame.size.height = view.frame.height - navigationBarHeight - statusBarHeight
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(type: ScoreCardCell.self)
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let toAnalysisButton = UIBarButtonItem(title: "解析", style: .plain, target: self, action: #selector(ScoreViewController.didTapToAnalysisButton(sender:)))
        navigationItem.rightBarButtonItem = toAnalysisButton
    }
    
    func didTapToAnalysisButton(sender: UIBarButtonItem) {
        let analysisViewController = AnalysisViewController(timeLine: timeLine)
        navigationController?.pushViewController(analysisViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UITableViewDataSource

extension ScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redList?.numerOfAnimals ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScoreCardCell = tableView.dequeueCell(indexPath: indexPath)
        let animal = redList!.getAnimal(with: indexPath.row)
        cell.update(with: animal)
        return cell
    }
}

