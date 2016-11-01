import XCTest

@testable import TodoSwift

class MockPersistanceService: Persistance {
	var countOfSaveCalls = 0
	var countOfLoadCalls = 0

	func save(data: Data, filename: String) -> (Bool, FilePersistanceError?) {
		countOfSaveCalls += 1
		return (false, nil)
	}

	func load(filename: String) -> (Data?, FilePersistanceError?) {
		countOfLoadCalls += 1
		return (nil, nil)
	}
}

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

	func testTodoRepositoryExists() {
		XCTAssertNotNil(sut);
	}

	func testWhenSettingThePersistanceService_RepositoryAttemptsToLoadTodos() {
		let mockPersistanceService = MockPersistanceService()

		XCTAssertEqual(0, mockPersistanceService.countOfLoadCalls)
		sut.persistanceService = mockPersistanceService

		XCTAssertEqual(1, mockPersistanceService.countOfLoadCalls)
	}

	func testAddingTodo_CountOfTodosIsIncremented() {
		let todo = Todo(name: "Test Todo", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo)

		XCTAssertEqual(1, sut.count())
	}

	func testAddingTodo_InvokesSaveCallOnPersistanceService() {
		let mockPersistanceService = MockPersistanceService()
		sut.persistanceService = mockPersistanceService
		XCTAssertEqual(0, mockPersistanceService.countOfSaveCalls)

		let todo = Todo(name: "Test Todo", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo)

		XCTAssertEqual(1, mockPersistanceService.countOfSaveCalls)
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

	func testUpdatingATodo() {
		// Given
		let todo = Todo(name: "Test Todo", favorited: false, state: .NotDone)
		let guid = todo.guid!
		sut.addTodo(todo: todo)

		// When
		if let fetchedTodo = sut.fetchTodo(guid: guid) {
			fetchedTodo.name = "Bob Todo"
			fetchedTodo.favorited = true
			fetchedTodo.state = .Done
			sut.update(todo:fetchedTodo)
		}

		// Then
		if let updatedTodoReFetched = sut.fetchTodo(guid: guid) {
			XCTAssertEqual("Bob Todo", updatedTodoReFetched.name!)
			XCTAssertEqual(true, updatedTodoReFetched.favorited)
			XCTAssertEqual(.Done, updatedTodoReFetched.state)
		}
	}

	func testUpdatingATodo_InvokesSaveCallOnPersistanceService() {
		let mockPersistanceService = MockPersistanceService()
		sut.persistanceService = mockPersistanceService

		let todo = Todo(name: "Test Todo", favorited: false, state: .NotDone)
		sut.addTodo(todo: todo)

		let currentSaveCount = mockPersistanceService.countOfSaveCalls
		if let fetchedTodo = sut.fetchTodo(guid: todo.guid!) {
			fetchedTodo.name = "Updated Name for Todo"
			sut.update(todo:fetchedTodo)
		}

		XCTAssertEqual(currentSaveCount + 1, mockPersistanceService.countOfSaveCalls)
	}
	
	// fetch either Done or NotDone todo
}
