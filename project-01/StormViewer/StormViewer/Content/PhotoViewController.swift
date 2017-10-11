
import UIKit

class PhotoViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
	var selectedImage: String? = nil

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.black
		
		navigationItem.title = selectedImage
		navigationItem.largeTitleDisplayMode = .never
		
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
}
