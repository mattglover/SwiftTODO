import Foundation

class TodoRepository {

	static let todosDataFilename = "todos.dat"

	var todos = Dictionary<String, Todo>()
	var persistanceService: Persistance? {
		didSet {
			loadTodos()
		}
	}

	func addTodo(todo: Todo) {
		if let unwrappedGUID = todo.guid {
			todos[unwrappedGUID] = todo
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
		if let (_, _) = persistanceService?.save(data: todosData, filename: TodoRepository.todosDataFilename) {}
	}

	private func loadTodos() {
		if let (data, error) = persistanceService?.load(filename: TodoRepository.todosDataFilename) {
			if data != nil {
				todos = NSKeyedUnarchiver.unarchiveObject(with: data!) as! Dictionary<String, Todo>
			} else if error == FilePersistanceError.unableToLoadFile {
				// Handle Error
			}
		}
	}
}
