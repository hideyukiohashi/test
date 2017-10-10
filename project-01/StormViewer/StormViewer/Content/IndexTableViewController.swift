
import UIKit

class IndexTableViewController: UITableViewController {
	var photos = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Cereal Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)

		for item in items {
			if item.hasPrefix("cereal") {
				photos.append(item)
			}
		}
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell", for: indexPath)
		cell.textLabel?.text = photos[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoStoryboard") as? PhotoViewController {
			vc.selectedImage = photos[indexPath.row]
			navigationController?.pushViewController(vc, animated: true)
		}
		tableView.deselectRow(at: indexPath, animated: false)
	}

	override func prefersHomeIndicatorAutoHidden() -> Bool {
		return true
	}
}
