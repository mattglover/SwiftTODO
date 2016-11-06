import XCTest
@testable import TodoSwift

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

	func testWhenCreated_TableViewAddedAsSubview() {
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
