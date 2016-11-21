import UIKit

class FavoriteToolbar: UIToolbar {

	fileprivate lazy var segmentedControl : UISegmentedControl = {
		let segmentedControl = UISegmentedControl(frame: .zero);
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		return segmentedControl
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInitialization()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInitialization()
	}
}

extension FavoriteToolbar {
	fileprivate func commonInitialization() {
		translatesAutoresizingMaskIntoConstraints = false
		addSubview(segmentedControl)

		segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
		segmentedControl.insertSegment(withTitle: "Favorite", at: 1, animated: false)
	}
}

