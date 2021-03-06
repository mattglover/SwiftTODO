import Foundation

class TodoRepository: TodoRepositoryProtocol {

	static let todosDataFilename = "todos.dat"

	var todos = Dictionary<String, Todo>()
	var persistanceService: PersistanceServiceProtocol? {
		didSet {
			loadTodos()
		}
	}

	lazy var notificationCenter: NotificationCenter = {
		return .default
	}()

	func addTodo(todo: Todo) {
		if let unwrappedGUID = todo.guid {
			todos[unwrappedGUID] = todo
			notificationCenter.post(name: Notification.Name("todoRepositoryServiceDidAddNewTodo"), object: todo)
			saveTodos(todos: todos)
		}
	}

	func update(todo: Todo) {
		todos[todo.guid!] = todo
		saveTodos(todos: todos)
	}

	func count() -> Int {
		return todos.count
	}

	/// Method to fetch a Todo if present in respository
	///
	/// - parameter guid: a Todo's unique identifier
	///
	/// - returns: Todo
	func fetchTodo(guid: String) -> Todo? {
		return todos[guid]
	}

	private func saveTodos(todos: Dictionary<String, Todo>) {
		let todosData = NSKeyedArchiver.archivedData(withRootObject: todos)

		do {
			let _ = try persistanceService?.save(data: todosData, filename: TodoRepository.todosDataFilename)
		} catch let error as FilePersistanceError {
			print(error)
		} catch let error {
			print(error)
		}
	}

	private func loadTodos() {
		do {
			if let data = try persistanceService?.load(filename: TodoRepository.todosDataFilename) {
				todos = NSKeyedUnarchiver.unarchiveObject(with: data) as! Dictionary<String, Todo>
			}
		} catch let error as FilePersistanceError {
			print(error)
		} catch let error {
			print(error)
		}
	}
}
