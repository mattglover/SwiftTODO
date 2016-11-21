protocol AddNewTodoViewControllerProtocol {
	init(delegate: AddNewTodoViewControllerDelegate?)
}

protocol AddNewTodoViewControllerDelegate {
	func addNewTodoViewController(viewController: AddNewTodoViewControllerProtocol, didCreateTodo todo: Todo)
	func addNewTodoViewControllerDidCancel(viewController: AddNewTodoViewControllerProtocol)
}
