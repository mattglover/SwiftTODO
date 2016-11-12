import XCTest
@testable import TodoSwift

class AddNewTodoViewControllerTest: XCTestCase {

	var sut: AddNewTodoViewController!
	let mockDelegate = MockDelegate()

    override func setUp() {
        super.setUp()
        sut = AddNewTodoViewController(delegate: mockDelegate)
    }
    
    override func tearDown() {
		sut = nil;
        super.tearDown()
    }

	func testConformsToAddNewTodoViewControllerProtocol() {
		XCTAssertNotNil(sut as AddNewTodoViewControllerProtocol) // Actually compiler error if sut doesn't implement protocol
	}

	func testCreatingWithoutDelegate_delegateIsNil() {
		sut = AddNewTodoViewController()
		XCTAssertNil(sut.delegate)
	}

	func testCreatingWithDelegate_delegateIsNotNil() {
		XCTAssertNotNil(sut.delegate)
	}

	// MARK: Save Button
	func testSaveButtonHasTargetAndAction() {
		let _ = sut.view
		let saveButton: UIBarButtonItem = sut.navigationItem.rightBarButtonItem!

		XCTAssertNotNil(saveButton);
		XCTAssertNotNil(saveButton.target)
		XCTAssertNotNil(saveButton.action)
	}

	func testSaveButtonTapped_callsCorrectMethodOnDelegate() {
		let _ = sut.view
		let saveButton: UIBarButtonItem = sut.navigationItem.rightBarButtonItem!
		XCTAssertEqual(#selector(AddNewTodoViewController.saveButtonTapped), saveButton.action!)

		XCTAssertFalse(mockDelegate.delegateDidCreateTodoWasCalled)
		sut.saveButtonTapped()
		XCTAssertTrue(mockDelegate.delegateDidCreateTodoWasCalled)
	}

	// MARK: Cancel Button
	func testCancelButtonHasTargetAndAction() {
		let _ = sut.view
		let cancelButton: UIBarButtonItem = sut.navigationItem.leftBarButtonItem!

		XCTAssertNotNil(cancelButton);
		XCTAssertNotNil(cancelButton.target)
		XCTAssertNotNil(cancelButton.action)
	}

	func testCancelButtonTapped_callsCorrectMethodOnDelegate() {
		let _ = sut.view
		let cancelButton: UIBarButtonItem = sut.navigationItem.leftBarButtonItem!
		XCTAssertEqual(#selector(AddNewTodoViewController.cancelButtonTapped), cancelButton.action!)

		XCTAssertFalse(mockDelegate.delegateCanceledWasCalled)
		sut.cancelButtonTapped()
		XCTAssertTrue(mockDelegate.delegateCanceledWasCalled)
	}


	// MARK: Subviews
	func testBackgroundColorIsWhite() {
		let _ = sut.view
		XCTAssertEqual(sut.view.backgroundColor, .white)
	}

	func testHasCorrectSubviews() {
		let _ = sut.view

		XCTAssertNotNil(sut.todoNameLabel)
		XCTAssertNotNil(sut.todoNameTextField)

		XCTAssertEqual(sut.view, sut.todoNameLabel.superview)
		XCTAssertEqual(sut.view, sut.todoNameTextField.superview)
	}

	func testTodoNameTextField_hasADelegate() {
		let _ = sut.view

		XCTAssertNotNil(sut.todoNameTextField.delegate)
	}

	// MARK: Mock Objects
	class MockDelegate: AddNewTodoViewControllerDelegate {

		var delegateCanceledWasCalled = false
		var delegateDidCreateTodoWasCalled = false

		func addNewTodoViewController(viewController: AddNewTodoViewControllerProtocol, didCreateTodo: Todo) {
			delegateDidCreateTodoWasCalled = true
		}

		func addNewTodoViewControllerDidCancel(viewController: AddNewTodoViewControllerProtocol){
			delegateCanceledWasCalled = true
		}
	}
}
