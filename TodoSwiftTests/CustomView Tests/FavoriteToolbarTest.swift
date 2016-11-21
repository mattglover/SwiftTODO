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

	// MARK: SegmentedControl
	func testSegmentedControl_hasHasTwoSegments() {
		let segmentedControl = self.segmentedControl(fromToolbar: sut)

		XCTAssertEqual(2, segmentedControl.numberOfSegments)
	}

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
}
