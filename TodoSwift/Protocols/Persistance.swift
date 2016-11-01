import Foundation

protocol Persistance {
	func save(data: Data, filename: String) -> (Bool, FilePersistanceError?)
	func load(filename: String) -> (Data?, FilePersistanceError?)
}
