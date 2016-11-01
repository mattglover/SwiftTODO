import Foundation

class TodoRepository {

	var todos = Dictionary<String, Todo>()

	func addTodo(todo: Todo) {
		if let unwrappedGUID = todo.guid {
			todos[unwrappedGUID] = todo
		}

	}

	func count() -> Int {
		return todos.count
	}

	/// Method to fetch a Todo if present in respoitory
	///
	/// - parameter guid: String a Todo's unique identifier
	///
	/// - returns: Todo
	func fetchTodo(guid: String) -> Todo? {
		return todos[guid]
	}

}
