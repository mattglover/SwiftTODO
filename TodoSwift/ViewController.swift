
import UIKit

class ViewController: UIViewController {

	var todoRepository: TodoRepositoryProtocol!

	override func viewDidLoad() {
		super.viewDidLoad()

		todoRepository = TodoRepository()
		todoRepository.persistanceService = FilePersistanceService()

//		let todo1 = Todo(name: "Todo 1", favorited: false, state: .NotDone)
//		let todo2 = Todo(name: "Todo 2", favorited: false, state: .NotDone)
//		let todo3 = Todo(name: "Todo 3", favorited: false, state: .NotDone)
//		let todo4 = Todo(name: "Todo 4", favorited: false, state: .NotDone)
//		let todo5 = Todo(name: "Todo 5", favorited: false, state: .NotDone)
//		todoRepository.addTodo(todo: todo1)
//		todoRepository.addTodo(todo: todo2)
//		todoRepository.addTodo(todo: todo3)
//		todoRepository.addTodo(todo: todo4)
//		todoRepository.addTodo(todo: todo5)
	}
	
}

