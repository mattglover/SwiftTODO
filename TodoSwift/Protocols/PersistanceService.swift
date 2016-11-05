import Foundation

protocol PersistanceService {
	func save(data: Data, filename: String) throws -> Bool
	func load(filename: String) throws -> Data?
}
