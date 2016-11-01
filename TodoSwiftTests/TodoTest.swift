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
		XCTAssertEqual(sut.favorited!, false)
		XCTAssertEqual(sut.state!, .NotDone)
		XCTAssertTrue(sut.debugDescription.contains("> NAME:NO-NAME FAVOURITE:false STATE:NotDone"))
	}

	func testCanBeCreatedWithPartialParamaters() {
		sut = Todo(name: "Todo Item 1", favorited: true, state: .NotDone)

		XCTAssertNotNil(sut)
		XCTAssertNotNil(sut.guid)
		XCTAssertEqual(sut.name!, "Todo Item 1")
		XCTAssertEqual(sut.favorited!, true)
		XCTAssertEqual(sut.state!, .NotDone)
		XCTAssertTrue(sut.debugDescription.contains("> NAME:Todo Item 1 FAVOURITE:true STATE:NotDone"))
	}

	func testCanBeCreatedWithAllParamaters() {
		sut = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z", name: "Todo Item 1", favorited: true, state: .NotDone)

		XCTAssertNotNil(sut)
		XCTAssertEqual(sut.guid!, "ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z")
		XCTAssertEqual(sut.name!, "Todo Item 1")
		XCTAssertEqual(sut.favorited!, true)
		XCTAssertEqual(sut.state!, .NotDone)
		XCTAssertEqual(sut.debugDescription, "[TODO]<ABCDE-FGHIJKLMNO-PQRST-UVWXY-Z> NAME:Todo Item 1 FAVOURITE:true STATE:NotDone")
	}

	func testCustomDebugStringConvertible() {
		sut = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .NotDone)
		XCTAssertEqual(sut.debugDescription, "[TODO]<ABCDE-FGHIJKLMNO-PQRST-1234-Z> NAME:Todo Item 1 FAVOURITE:true STATE:NotDone")
	}

	func testEquality() {
		let todo1 = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .NotDone)
		let todo2 = Todo(guid:"ABCDE-FGHIJKLMNO-PQRST-1234-Z", name: "Todo Item 1", favorited: true, state: .NotDone)

		XCTAssertEqual(todo1, todo2)
	}
}
