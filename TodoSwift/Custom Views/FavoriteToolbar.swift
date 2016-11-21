import UIKit

protocol FavoriteToolbarDelegate {
	func favoriteToolbar(_ toolbar: FavoriteToolbar, didSelectOption: FavoriteToolbarSelection?)
}

/// Simple Toolbar with two segment Control with "All" and "Favorite" options
/// deliberately simple and un-flexible conforming to TDD principles.
/// fighting the instinct to over-engineer a solution :)
///
class FavoriteToolbar: UIToolbar {

	var favoriteToolbarDelegate: FavoriteToolbarDelegate?

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

		segmentedControl.insertSegment(withTitle: NSLocalizedString("All", comment: ""), at: 0, animated: false)
		segmentedControl.insertSegment(withTitle: NSLocalizedString("Favorite", comment: ""), at: 1, animated: false)
		segmentedControl.addTarget(self, action: #selector(FavoriteToolbar.segmentedControlValueChanged(_:)), for: .valueChanged)
	}

	func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			favoriteToolbarDelegate?.favoriteToolbar(self, didSelectOption: .all)
		case 1:
			favoriteToolbarDelegate?.favoriteToolbar(self, didSelectOption: .favorite)
		default:
			favoriteToolbarDelegate?.favoriteToolbar(self, didSelectOption: nil)
		}
	}
}
