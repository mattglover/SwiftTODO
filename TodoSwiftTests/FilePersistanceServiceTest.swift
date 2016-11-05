import XCTest

@testable import TodoSwift

class FilePersistanceServiceTest: XCTestCase {

	var sut: FilePersistanceService!

    override func setUp() {
        super.setUp()
        sut = FilePersistanceService()
    }
    
    override func tearDown() {
		sut = nil
        super.tearDown()
    }

	func testCanSaveData() {
		let array = ["Matt", "John", "David", "Travis"]
		let data = NSKeyedArchiver.archivedData(withRootObject: array)
		let filename = "testCanSaveData.dat"

		let saveSuccess = try! sut.save(data: data, filename: filename)

		XCTAssertTrue(saveSuccess)
	}

	func testCanLoadDataFromFilename() {
		let array = ["David", "Travis"]
		let data = NSKeyedArchiver.archivedData(withRootObject: array)
		let filename = "testCanLoadDataFromFilename.dat"

		let _ = try! sut.save(data: data, filename: filename)

			if let loadedData = try! sut.load(filename: filename) {

				let loadedArray = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as! [String]

				XCTAssertNotNil(loadedData)
				XCTAssertEqual(2, loadedArray.count)
			}
		}

	func testTryingToLoadDataWithInvalidFilename_throwsAnError() {
		let filename = "fileDoesNotExistFilename.dat"

		XCTAssertThrowsError(try sut.load(filename: filename))
	}
}
