
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

		self.title = "Todos"

		let toolbar = UIToolbar.init(frame: .zero)
		toolbar.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(toolbar)

		let tableview = UITableView.init(frame: .zero, style: .plain)
		tableview.translatesAutoresizingMaskIntoConstraints = false
		tableview.delegate   = self
		tableview.dataSource = self
		tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		self.view.addSubview(tableview)

		let views   = ["tableview" : tableview, "toolbar" : toolbar]
		let metrics = ["toolbarHeight" : 44.0]
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|[toolbar]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|[tableview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "V:|[tableview][toolbar(toolbarHeight)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.navigationBar.isTranslucent = false
		self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)

		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(ViewController.addButtonTapped))
	}

	func addButtonTapped() {
		let addNewTodoViewController = AddNewTodoViewController(delegate: self)
		let navigationViewController = UINavigationController(rootViewController: addNewTodoViewController)
		self.present(navigationViewController, animated: true, completion: nil)
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

extension ViewController: AddNewTodoViewControllerDelegate {
	internal func addNewTodoViewController(viewController: AddNewTodoViewControllerProtocol, didCreateTodo: Todo) {
		print("addNewTodoViewController:didCreateTodo:")
	}

	internal func addNewTodoViewControllerDidCancel(viewController: AddNewTodoViewControllerProtocol) {
		self.dismiss(animated: true, completion: nil)
	}
}

