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

	func fetchTodo(guid: String) -> Todo? {
		return todos[guid]
	}

}
