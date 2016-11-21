import XCTest

@testable import TodoSwift

class FavoriteToolbarTest: XCTestCase {

	var sut: FavoriteToolbar!

	override func setUp() {
		super.setUp()
		sut = FavoriteToolbar(frame: .zero)

	}

	override func tearDown() {
		sut = nil
		super.tearDown()
	}

	func testWhenCreated_hasASegmentedControlSubview() {
		var hasSegmentedControl = false
		for subview in sut.subviews {
			if subview.isKind(of: UISegmentedControl.self) {
				hasSegmentedControl = true
				break
			}
		}

		XCTAssertTrue(hasSegmentedControl)
	}

	// MARK: Favorite Toolbar
	func testFavoriteToolbarInitialSelectedOption_IsAll() {
		XCTAssertEqual(.all, sut.selectedOption)
	}

	// MARK: Delegate and Delegate Methods
	func testDoesNotHaveADelegateUnlessDelegateIsSet() {
		XCTAssertNil(sut.delegate)

		let mockDelegate = MockFavoriteToolbarDelegate()
		sut.favoriteToolbarDelegate = mockDelegate

		XCTAssertNotNil(sut.favoriteToolbarDelegate)
	}

	func testDelegateIsCalledWhenSegmentChanges() {
		let mockDelegate = MockFavoriteToolbarDelegate()

		sut.favoriteToolbarDelegate = mockDelegate
		let segmentedControl = self.segmentedControl(fromToolbar: sut)
		segmentedControl.selectedSegmentIndex = 1
		segmentedControl.sendActions(for: .valueChanged)
		XCTAssertEqual(.favorite, mockDelegate.delegateDidSelectedIndex);

		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.sendActions(for: .valueChanged)
		XCTAssertEqual(.all, mockDelegate.delegateDidSelectedIndex);
	}

	// MARK: SegmentedControl
	func testSegmentedControl_hasHasTwoSegments() {
		let segmentedControl = self.segmentedControl(fromToolbar: sut)

		XCTAssertEqual(2, segmentedControl.numberOfSegments)
	}

	// MARK: Helpers
	func segmentedControl(fromToolbar: FavoriteToolbar) -> UISegmentedControl {
		var segmentedControl: UISegmentedControl!
		for subview in fromToolbar.subviews {
			if subview.isKind(of: UISegmentedControl.self) {
				segmentedControl = subview as! UISegmentedControl
				break
			}
		}
		return segmentedControl
	}

	// MARK: Mock Object(s)
	class MockFavoriteToolbarDelegate: FavoriteToolbarDelegate {
		var delegateDidSelectedIndex: FavoriteToolbarSelection?

		func favoriteToolbar(_ toolbar: FavoriteToolbar, didSelectOption: FavoriteToolbarSelection?) {
				delegateDidSelectedIndex = didSelectOption
		}
	}
}
