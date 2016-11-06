protocol TodoRepository {

	var persistanceService: PersistanceService?{ get set }

	func addTodo(todo: Todo)
	func update(todo: Todo)
	func count() -> Int

	/// Method to fetch a Todo if present in respository
	///
	/// - parameter guid: a Todo's unique identifier
	///
	/// - returns: Todo
	func fetchTodo(guid: String) -> Todo?
}
