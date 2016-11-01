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
		XCTAssertTrue(sut.debugDescription.contains("> NAME:NO-NAME FAVOURTIE:false STATE:NotDone"))
	}

	func testCanBeCreatedWithParamaters() {
		sut = Todo(guid: nil, name: "Todo Item 1", favorited: true, state: .NotDone)

		XCTAssertNotNil(sut)
		XCTAssertNotNil(sut.guid)
		XCTAssertEqual(sut.name!, "Todo Item 1")
		XCTAssertEqual(sut.favorited!, true)
		XCTAssertEqual(sut.state!, .NotDone)
		XCTAssertTrue(sut.debugDescription.contains("> NAME:Todo Item 1 FAVOURTIE:true STATE:NotDone"))
	}
}
