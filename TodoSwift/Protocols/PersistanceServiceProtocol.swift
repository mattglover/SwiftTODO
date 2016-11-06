import Foundation

protocol PersistanceServiceProtocol {
	func save(data: Data, filename: String) throws -> Bool
	func load(filename: String) throws -> Data?
}
