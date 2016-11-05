enum FilePersistanceError: Error {
	case unableToSaveFile(filename: String)
	case unableToLoadFile(filename: String)
}

enum TodoState : String {
	case NotDone = "NotDone"
	case Done = "Done"
}
