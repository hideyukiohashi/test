
import UIKit

private let reuseIdentifier = "Cell"

class IndexCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollection", for: indexPath) as! PersonCollectionViewCell
		let person = people[indexPath.row]
		cell.nameLabel.text = person.name
		
		let path = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)
		
		cell.imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		cell.imageView.layer.borderWidth = 2
		cell.imageView.layer.cornerRadius = 3
		cell.layer.cornerRadius = 7
		
		return cell
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let person = people[indexPath.item]
		let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
			let newName = ac.textFields![0]
			person.name = newName.text!
			self.collectionView?.reloadData()
		}))
		
		present(ac, animated: true, completion: nil)
	}
	
	@objc private func addNewPerson() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self // UIImagePickerControllerDelegate, UINavigationControllerDelegate
		present(picker, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
			return
		}
		
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let jpegData = UIImageJPEGRepresentation(image, 80) {
			try? jpegData.write(to: imagePath)
		}
		
		let persop = Person(name: "Unknown", image: imageName)
		people.append(persop)
		collectionView?.reloadData()
		
		dismiss(animated: true, completion: nil)
	}
	
	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	
	
	
	
}
