import XCTest

@testable import TodoSwift

class TodoTest: XCTestCase {

	var sut: Todo!

    override func setUp() {
        super.setUp()
		sut = Todo();
    }
    
    override func tearDown() {
		sut = nil;
        super.tearDown()
    }

	func testCreateWithBaseInit_todoExistsWithDefaultValues() {
		XCTAssertNotNil(sut)
		XCTAssertNotNil(sut.guid)
		XCTAssertNil(sut.name)
		XCTAssertEqual(sut.isFavorited!, false)
		XCTAssertEqual(sut.state!, .notDone)
		XCTAssertTrue(sut.debugDescription.contains("> NAME:NO-NAME FAVOURITE:false STATE:notDone"))
	}

	func testCanBeCreatedWithPartialParamaters() {
		sut = Todo(name: "Todo Item 1", favorited: true, state: .notDone)

		XCTAssertNotNil(sut)
		XCTAssertNotNil(sut.guid)
		XCTAssertEqual(sut.name!, "Todo Item 1")
		XCTAssertEqual(sut.isFavorited!, true)
		XCTAssertEqual(sut.state!, .notDone)
		XCTAssertTrue(sut.debugDescription.contains("> NAME:Todo Item 1 FAVOURITE:true STATE:notDone"))
	}

	func testCanBeCreatedWithAllParamaters() {
		sut = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z", name: "Todo Item 1", favorited: true, state: .notDone)

		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.guid!, "ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z")
		XCTAssertEqual(sut.name!, "Todo Item 1")
		XCTAssertEqual(sut.isFavorited!, true)
		XCTAssertEqual(sut.state!, .notDone)
		XCTAssertEqual(sut.debugDescription, "[TODO]<ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z> NAME:Todo Item 1 FAVOURITE:true STATE:notDone")
	}

	func testCustomDebugStringConvertible() {
		sut = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .notDone)
		XCTAssertEqual(sut.debugDescription, "[TODO]<ABCDE-FGHIJKLMNO-PQRST-1234-Z> NAME:Todo Item 1 FAVOURITE:true STATE:notDone")
	}

	func testEquality() {
		let todo1 = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .notDone)
		let todo2 = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .notDone)

		XCTAssertTrue(todo1 == todo2)
	}

	func testCanEncodeAndDecode() {
		let todo = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .notDone)
		let archive = NSKeyedArchiver.archivedData(withRootObject: todo)

		let unarchivedTodo = NSKeyedUnarchiver.unarchiveObject(with: archive) as! Todo

		XCTAssertTrue(unarchivedTodo == todo)
	}
}
