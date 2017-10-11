
import UIKit

class PhotoViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
	var selectedImage: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.black
		
		navigationItem.title = selectedImage
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tappedShare(sender:)))
		
		if let imageToLoad = selectedImage {
			imageView.image = UIImage(named: imageToLoad)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
	
	override func prefersHomeIndicatorAutoHidden() -> Bool {
		return navigationController!.hidesBarsOnTap
	}
	
	@objc private func tappedShare(sender: UIBarButtonItem) {
		let text = "Project 03"
		let url = URL(string: "https://www.apple.com")!
		let image = imageView.image!
		let activityItems = [text, url, image] as [Any]
		let vc = UIActivityViewController(activityItems:activityItems, applicationActivities: nil)
		/**
		let excludedActivityTypes = [
			UIActivityType.addToReadingList,
			UIActivityType.saveToCameraRoll,
			UIActivityType.postToWeibo,
			UIActivityType.print
		]
		vc.excludedActivityTypes = excludedActivityTypes
		*/
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true, completion: nil)
	}
}
