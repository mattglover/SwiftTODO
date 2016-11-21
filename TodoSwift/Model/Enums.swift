enum FilePersistanceError: Error {
	case unableToSaveFile(filename: String)
	case unableToLoadFile(filename: String)
}

enum TodoState: String {
	case notDone = "NotDone"
	case done = "Done"
}

enum FavoriteToolbarSelection: String {
	case all = "All"
	case favorite = "Favorite"
}
