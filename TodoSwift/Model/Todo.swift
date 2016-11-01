import Foundation

class Todo: NSObject, NSCoding {

	var guid: String!
	var name: String?
	var favorited: Bool!
	var state: TodoState!

	// MARK: Serialization Keys
	struct PropertyKey {
		static let guidKey 		= "guid"
		static let nameKey 		= "name"
		static let favoritedKey = "favorited"
		static let stateKey 	= "state"
	}

	// MARK: Initialization
	init(guid: String?, name: String?, favorited: Bool, state: TodoState) {

		if let localGuid = guid {
			self.guid = localGuid
		} else {
			self.guid = UUID().uuidString
		}

		self.name = name
		self.favorited = favorited
		self.state = state

		super.init()
	}

	convenience override init() {
		self.init(guid: nil, name: nil, favorited: false, state: .NotDone)
	}

	convenience init(name: String?, favorited: Bool, state: TodoState) {
		self.init(guid: nil, name: name, favorited: favorited, state: state)
	}

	// MARK: NSCoding
	func encode(with aCoder: NSCoder) {
		aCoder.encode(guid, 			forKey: PropertyKey.guidKey)
		aCoder.encode(name, 			forKey: PropertyKey.nameKey)
		aCoder.encode(favorited,		forKey: PropertyKey.favoritedKey)
		aCoder.encode(state.rawValue, 	forKey: PropertyKey.stateKey)
	}

	required convenience init?(coder aDecoder: NSCoder) {
		let guid = aDecoder.decodeObject(forKey: PropertyKey.guidKey) as! String
		let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
		let favorited = aDecoder.decodeObject(forKey: PropertyKey.favoritedKey) as! Bool
		let state = TodoState(rawValue: aDecoder.decodeObject(forKey: PropertyKey.stateKey) as! String)!

		self.init(guid: guid, name: name, favorited: favorited, state: state)
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
