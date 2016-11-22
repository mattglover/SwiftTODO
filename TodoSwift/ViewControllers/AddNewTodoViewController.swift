import UIKit

/// This is a simple View Controller with not persistance dependancy
/// Activity performed with this AddNewTodoViewController is reported
/// via is delegate `AddNewTodoViewControllerDelegate`

class AddNewTodoViewController: UIViewController, AddNewTodoViewControllerProtocol, UITextFieldDelegate {

	var delegate: AddNewTodoViewControllerDelegate?

	let todoNameLabel 	  = UILabel()
	let favoriteLabel 	  = UILabel()
	let completeLabel 	  = UILabel()
	let todoNameTextField = UITextField()
	let favoriteSwitch 	  = UISwitch()
	let completeSwitch 	  = UISwitch()

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
		todoNameLabel.text = NSLocalizedString("Todo Name:", comment: "")
		self.view.addSubview(todoNameLabel)

		favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
		favoriteLabel.text = NSLocalizedString("Favorite:", comment: "")
		self.view.addSubview(favoriteLabel)

		completeLabel.translatesAutoresizingMaskIntoConstraints = false
		completeLabel.text = NSLocalizedString("Complete:", comment: "")
		self.view.addSubview(completeLabel)

		favoriteSwitch.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(favoriteSwitch)

		completeSwitch.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(completeSwitch)

		todoNameTextField.translatesAutoresizingMaskIntoConstraints = false
		todoNameTextField.delegate = self
		todoNameTextField.addTarget(self, action: #selector(AddNewTodoViewController.textFieldDidChange(sender:)), for: UIControlEvents.editingChanged)
		todoNameTextField.borderStyle = .roundedRect
		self.view.addSubview(todoNameTextField)
	}

	func setupConstraints() {
		let views   = ["todoNameLabel" : todoNameLabel,
		               "todoNameTextField" : todoNameTextField,
					   "favoriteLabel" : favoriteLabel,
					   "completeLabel" : completeLabel,
					   "favoriteSwitch": favoriteSwitch,
					   "completeSwitch": completeSwitch]


		let metrics:[String:Any] = [:]
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|-[todoNameLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|-(16)-[todoNameTextField]-(16)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|-[favoriteLabel]-(<=8)-[favoriteSwitch]-(16)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "H:|-[completeLabel]-(<=8)-[completeSwitch]-(16)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint .constraints(withVisualFormat: "V:|-(64)-[todoNameLabel]-(8)-[todoNameTextField]-(32)-[favoriteLabel]-(32)-[completeLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))

		NSLayoutConstraint.activate([NSLayoutConstraint (item: favoriteSwitch, attribute: .centerY, relatedBy: .equal, toItem: favoriteLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)])
		NSLayoutConstraint.activate([NSLayoutConstraint (item: completeSwitch, attribute: .centerY, relatedBy: .equal, toItem: completeLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)])
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationItem.leftBarButtonItem  = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(AddNewTodoViewController.cancelButtonTapped))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(AddNewTodoViewController.saveButtonTapped))

		self.updateUI()
	}

	func updateUI() {
		let isNotEmptyString = (todoNameTextField.text?.characters.count)! > 0
		self.navigationItem.rightBarButtonItem?.isEnabled = isNotEmptyString
	}

	func saveButtonTapped() {
		guard let todoName = todoNameTextField.text else {
			return
		}

		let todoDoneState: TodoState = completeSwitch.isOn ? .done : .notDone
		let todo = Todo(name: todoName, favorited: favoriteSwitch.isOn, state: todoDoneState)
		delegate?.addNewTodoViewController(viewController: self, didCreateTodo: todo)
	}

	func cancelButtonTapped() {
		delegate?.addNewTodoViewControllerDidCancel(viewController: self)
	}

	func textFieldDidChange(sender: UITextField) {
		updateUI()
	}
}
