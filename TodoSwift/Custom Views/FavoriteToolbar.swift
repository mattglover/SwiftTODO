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
	var selectedOption: FavoriteToolbarSelection? = .all

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

		let views = ["segmentedControl" : segmentedControl]
		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[segmentedControl]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
		NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[segmentedControl]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

		setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
		segmentedControl.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)

		segmentedControl.insertSegment(withTitle: NSLocalizedString("All", comment: ""), at: 0, animated: false)
		segmentedControl.insertSegment(withTitle: NSLocalizedString("Favorite", comment: ""), at: 1, animated: false)
		segmentedControl.addTarget(self, action: #selector(FavoriteToolbar.segmentedControlValueChanged(_:)), for: .valueChanged)
	}

	func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			selectedOption = .all
		case 1:
			selectedOption = .favorite
		default:
			selectedOption = nil
		}

		favoriteToolbarDelegate?.favoriteToolbar(self, didSelectOption: selectedOption)
	}
}
