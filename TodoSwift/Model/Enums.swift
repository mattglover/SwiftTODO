enum FilePersistanceError: Error {
	case unableToSaveFile
	case unableToLoadFile
}

enum TodoState : String {
	case NotDone = "NotDone"
	case Done = "Done"
}
