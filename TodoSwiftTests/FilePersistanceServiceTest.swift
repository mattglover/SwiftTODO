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

		let (saveSuccess, error) = sut.save(data: data, filename: filename)

		XCTAssertTrue(saveSuccess)
		XCTAssertNil(error)
	}

	func testCanLoadDataFromFilename() {
		let array = ["David", "Travis"]
		let data = NSKeyedArchiver.archivedData(withRootObject: array)
		let filename = "testCanLoadDataFromFilename.dat"

		let (saveSuccess, _) = sut.save(data: data, filename: filename)
		XCTAssertTrue(saveSuccess)

		let (loadedData, error) = sut.load(filename: filename)
		if let thisData = loadedData {
			let loadedArray = NSKeyedUnarchiver.unarchiveObject(with: thisData) as! [String]

			XCTAssertNotNil(loadedData)
			XCTAssertNil(error)
			XCTAssertEqual(2, loadedArray.count)
		} else {
			XCTFail()
		}
	}
    
}
