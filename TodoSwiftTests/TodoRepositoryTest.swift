import XCTest

@testable import TodoSwift

class TodoRepositoryTest: XCTestCase {

	var sut: TodoRepository!

    override func setUp() {
        super.setUp()
		sut = TodoRepository()
    }
    
    override func tearDown() {
		sut = nil
        super.tearDown()
    }

	func testTestRepositoryExists() {
		XCTAssertNotNil(sut);
	}

	func testAddingTodo_CountOfTodosIsIncremented() {
		let todo = Todo(name: "Test Todo", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo)

		XCTAssertEqual(1, sut.count())
	}

	func testFetchTodoByValidGUID_returnsCorrectTodo() {
		let todo1 = Todo(guid:"ABCD-EDFGH", name: "Test Todo 1", favorited: false, state: .NotDone)
		let todo2 = Todo(guid:"ZYXW-UVTSR", name: "Test Todo 2", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo1)
		sut.addTodo(todo: todo2)

		if let fetchedTodo = sut.fetchTodo(guid:"ABCD-EDFGH") {
			XCTAssertEqual(fetchedTodo, todo1)
		} else {
			XCTFail()
		}
	}

	func testFetchTodoByInalidGUID_returnsNil() {
		let todo1 = Todo(guid:"ABCD-EDFGH", name: "Test Todo 1", favorited: false, state: .NotDone)
		let todo2 = Todo(guid:"ZYXW-UVTSR", name: "Test Todo 2", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo1)
		sut.addTodo(todo: todo2)

		let fetchedTodo = sut.fetchTodo(guid:"EDFGH-ABCD")
		XCTAssertNil(fetchedTodo)
	}

	// persist to disk
	// ability to fetch only the guid without loading all the TODOs
	// update todo
	// fetch either Done or NotDone todo
}
