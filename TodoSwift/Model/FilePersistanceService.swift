import Foundation

class FilePersistanceService : Persistance {

	let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!

	func save(data: Data, filename: String) -> (Bool, FilePersistanceError?) {
		let filePath = documentsDirectory.appendingPathComponent(filename)

		do {
			try data.write(to: filePath)
			return (true, nil)
		} catch {
			print("Error saving file: \(filePath)")
			return (false, FilePersistanceError.unableToSaveFile)
		}
	}

	func load(filename: String) -> (Data?, FilePersistanceError?) {
		let filePathURL = documentsDirectory.appendingPathComponent(filename)
		do {
			let data = try Data(contentsOf: filePathURL)
			return (data, nil)
		} catch  {
			print("Error loading file: \(filePathURL)")
			return (nil, FilePersistanceError.unableToLoadFile)
		}
	}
}