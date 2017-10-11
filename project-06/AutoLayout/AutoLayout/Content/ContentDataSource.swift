
import UIKit

struct Content {
	let title: String
	let target: String
	
	var viewController: UIViewController {
		get {
			let storyboard = UIStoryboard(name: target, bundle: nil)
			guard let vc = storyboard.instantiateInitialViewController() else {
				fatalError()
			}
			vc.title = title
			return vc
		}
	}
}

struct ContentDataSource {
	let contents = [
		Content(title: "InterfaceBuilder", target: "InterfaceBuilder"),
		Content(title: "SwiftCode", target: "SwiftCode")
	]
}
