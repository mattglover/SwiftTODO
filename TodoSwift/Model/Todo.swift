import Foundation

class Todo: CustomDebugStringConvertible {

	var guid: String!
	var name: String?
	var favorited: Bool!
	var state: TodoState!
	var debugDescription: String {
		if let name = self.name {
			return "[TODO]<\(guid!)> NAME:\(name) FAVOURTIE:\(favorited!) STATE:\(state!)"
		} else {
			return "[TODO]<\(guid!)> NAME:NO-NAME FAVOURTIE:\(favorited!) STATE:\(state!)"
		}
	}

	convenience init() {
		self.init(guid: nil, name: nil, favorited: false, state: .NotDone)
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
}
