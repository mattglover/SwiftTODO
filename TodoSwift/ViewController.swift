
import UIKit

class ViewController: UIViewController {

	let cellReuseIdentifier = "cellReuseIdentifier"

	var todoRepository: TodoRepositoryProtocol!
	var todos:[Todo]?


	// MARK: Initialization
	init(todoRepository: TodoRepository) {
		self.todoRepository = todoRepository
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init() {
		fatalError("invalid init called, please use init(todoRepository:) instead")
	}

	override func loadView() {
		super.loadView()
		self.setupSubviews()
	}

	func setupSubviews() {
		let tableview = UITableView.init(frame: .zero, style: .plain)
		tableview.translatesAutoresizingMaskIntoConstraints = false
		tableview.delegate   = self
		tableview.dataSource = self
		tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		self.view.addSubview(tableview)

		let views = ["tableview" : tableview]
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|[tableview]|", options: .alignAllLeft, metrics: nil, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "V:|[tableview]|", options: .alignAllTop, metrics: nil, views: views))
	}

	override func viewDidLoad() {
		super.viewDidLoad()

	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
		cell.textLabel!.text = "it works"
		return cell
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let todos = self.todos else {
			return 0
		}

		return todos.count
	}
}

