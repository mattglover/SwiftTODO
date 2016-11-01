import Foundation

class Todo: NSObject {

	var guid: String!
	var name: String?
	var favorited: Bool!
	var state: TodoState!

	convenience override init() {
		self.init(guid: nil, name: nil, favorited: false, state: .NotDone)
	}

	convenience init(name: String?, favorited: Bool, state: TodoState) {
		self.init(guid: nil, name: name, favorited: favorited, state: state)
	}

	init(guid: String?, name: String?, favorited: Bool, state: TodoState) {

		if let localGuid = guid {
			self.guid = localGuid
		} else {
			self.guid = UUID().uuidString
		}

		self.name = name
		self.favorited = favorited
		self.state = state
	}

	// MARK: Equatable
	static func ==(lhs: Todo, rhs: Todo) -> Bool {
		return
			(lhs.guid == rhs.guid &&
			lhs.name == rhs.name &&
			lhs.favorited == rhs.favorited &&
			lhs.state == rhs.state)
	}

	// MARK: CustomDebugStringConvertible
	override var debugDescription: String {
		if let name = self.name {
			return "[TODO]<\(guid!)> NAME:\(name) FAVOURITE:\(favorited!) STATE:\(state!)"
		} else {
			return "[TODO]<\(guid!)> NAME:NO-NAME FAVOURITE:\(favorited!) STATE:\(state!)"
		}
	}
}
