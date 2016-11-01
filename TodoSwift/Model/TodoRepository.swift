import Foundation

class TodoRepository {

	static let todosDataFilename = "todos.dat"

	var persistanceService: Persistance?
	var todos = Dictionary<String, Todo>()

	func addTodo(todo: Todo) {
		if let unwrappedGUID = todo.guid {
			todos[unwrappedGUID] = todo
			saveTodos(todos: todos)
		}
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
}
