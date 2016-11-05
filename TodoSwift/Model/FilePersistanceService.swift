import Foundation

class FilePersistanceService : PersistanceService {

	let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

	func save(data: Data, filename: String) throws -> Bool {
		let filePath = documentsDirectory.appendingPathComponent(filename)

		do {
			try data.write(to: filePath)
			return true
		} catch {
			throw FilePersistanceError.unableToSaveFile(filename: filename)
		}
	}

	func load(filename: String) throws -> Data? {
		let filePathURL = documentsDirectory.appendingPathComponent(filename)
		do {
			let data = try Data(contentsOf: filePathURL)
			return data
		} catch {
			throw FilePersistanceError.unableToLoadFile(filename: filename)
		}
	}
}
