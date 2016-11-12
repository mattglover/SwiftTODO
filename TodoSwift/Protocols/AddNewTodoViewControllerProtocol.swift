protocol AddNewTodoViewControllerProtocol {
	init(delegate: AddNewTodoViewControllerDelegate?)
}

protocol AddNewTodoViewControllerDelegate {
	func addNewTodoViewController(viewController: AddNewTodoViewControllerProtocol, didCreateTodo: Todo)
	func addNewTodoViewControllerDidCancel(viewController: AddNewTodoViewControllerProtocol)
}
