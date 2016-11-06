import XCTest
@testable import TodoSwift

class ViewControllerTest: XCTestCase {

	var sut: ViewController!

    override func setUp() {
        super.setUp()
		sut = ViewController(todoRepository: MockTodoRepository())
    }
    
    override func tearDown() {
		sut = nil
        super.tearDown()
    }

	func testWhenCreated_TodoRepositoryExists() {
		XCTAssertNotNil(sut.todoRepository)
	}

	func testWhenCreated_TableViewHasBeenAddedAsSubview() {
		var hasTableView = false
		for subview in sut.view.subviews {
			if subview.isKind(of: UITableView.self) {
    			hasTableView = true
				break
			}
		}

		XCTAssertTrue(hasTableView)
	}

	func testTableViewHasADataSourceAndDelegate() {
		let tableView = self.tableView(fromSubviews: sut.view.subviews)

		XCTAssertNotNil(tableView.delegate)
		XCTAssertNotNil(tableView.dataSource)
	}

	// MARK: UITableView DataSource Tests
	func testWhenTodosIsNil_TableViewDataSourceReturnsZeroForNumberOfRowsInSectionZero() {
		sut.todos = nil

		let tableView = self.tableView(fromSubviews: sut.view.subviews)
		let tableViewDataSource = tableView.dataSource

		XCTAssertEqual(0, tableViewDataSource?.tableView(tableView, numberOfRowsInSection: 0))
	}

	func testWhenTodosIsEmpty_TableViewDataSourceReturnsZeroForNumberOfRowsInSectionZero() {
		sut.todos = []

		let tableView = self.tableView(fromSubviews: sut.view.subviews)
		let tableViewDataSource = tableView.dataSource

		XCTAssertEqual(0, tableViewDataSource?.tableView(tableView, numberOfRowsInSection: 0))
	}

	func testWhenTodosHasTwoTodos_TableViewDataSourceReturnsTwoForNumberOfRowsInSectionZero() {
		let todo1 = Todo(name: "Test One", favorited: false, state: .NotDone)
		let todo2 = Todo(name: "Test Two", favorited: false, state: .NotDone)
		sut.todos = [todo1, todo2]

		let tableView = self.tableView(fromSubviews: sut.view.subviews)
		let tableViewDataSource = tableView.dataSource

		XCTAssertEqual(2, tableViewDataSource?.tableView(tableView, numberOfRowsInSection: 0))
	}

	// MARK: Mock Object(s)
	class MockTodoRepository: TodoRepository {

		override func addTodo(todo: Todo) {
			// Do something
		}

		override func update(todo: Todo) {
			// Do something
		}

		override func count() -> Int {
			return 0
		}

		override func fetchTodo(guid: String) -> Todo? {
			return nil
		}
	}


	// MARK: Helpers : TableView
	func tableView(fromSubviews: [UIView]) -> UITableView {
		var tableView: UITableView!
		for subview in fromSubviews {
			if subview.isKind(of: UITableView.self) {
				tableView = subview as! UITableView
				break
			}
		}
		return tableView
	}
}
