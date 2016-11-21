import UIKit

class AddNewTodoViewController: UIViewController, AddNewTodoViewControllerProtocol, UITextFieldDelegate {

	var delegate: AddNewTodoViewControllerDelegate?
	var todo = Todo()

	let todoNameLabel 	  = UILabel()
	let todoNameTextField = UITextField()

	required init(delegate: AddNewTodoViewControllerDelegate?) {
		self.delegate = delegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	convenience init() {
		self.init(delegate: nil)
	}

	override func loadView() {
		super.loadView()
		self.setupSubviews()
		self.setupConstraints()
	}

	func setupSubviews() {

		self.view.backgroundColor = .white
		self.title = NSLocalizedString("Add Todo", comment: "")

		todoNameLabel.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(todoNameLabel)

		todoNameTextField.translatesAutoresizingMaskIntoConstraints = false
		todoNameTextField.delegate = self
		self.view.addSubview(todoNameTextField)
	}

	func setupConstraints() {
		let views   = ["todoNameLabel" : todoNameLabel, "todoNameTextField" : todoNameTextField]
		let metrics:[String:Any] = [:]
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|[todoNameLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|[todoNameTextField]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "V:|-(64)-[todoNameLabel]-[todoNameTextField]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationItem.leftBarButtonItem  = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(AddNewTodoViewController.cancelButtonTapped))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(AddNewTodoViewController.saveButtonTapped))
	}

	func saveButtonTapped() {
		delegate?.addNewTodoViewController(viewController: self, didCreateTodo: todo)
	}

	func cancelButtonTapped() {
		delegate?.addNewTodoViewControllerDidCancel(viewController: self)
	}
}
