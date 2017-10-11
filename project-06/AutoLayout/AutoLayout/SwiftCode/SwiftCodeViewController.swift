
import UIKit
import Cartography

class SwiftCodeViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		
		let label1 = UILabel()
		label1.translatesAutoresizingMaskIntoConstraints = false
		label1.backgroundColor = UIColor(red: 0.96, green: 0.77, blue: 0.78, alpha: 1.0)
		label1.text = "f8c6c7"
		label1.textAlignment = NSTextAlignment.center
		label1.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label2 = UILabel()
		label2.translatesAutoresizingMaskIntoConstraints = false
		label2.backgroundColor = UIColor(red: 0.94, green: 0.79, blue: 0.14, alpha: 1.0)
		label2.text = "f2cb24"
		label2.textAlignment = NSTextAlignment.center
		label2.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label3 = UILabel()
		label3.translatesAutoresizingMaskIntoConstraints = false
		label3.backgroundColor = UIColor(red: 0.52, green: 0.78, blue: 0.63, alpha: 1.0)
		label3.text = "87c9a3"
		label3.textAlignment = NSTextAlignment.center
		label3.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label4 = UILabel()
		label4.translatesAutoresizingMaskIntoConstraints = false
		label4.backgroundColor = UIColor(red: 0.72, green: 0.89, blue: 0.96, alpha: 1.0)
		label4.text = "b9e4f7"
		label4.textAlignment = NSTextAlignment.center
		label4.font = UIFont.boldSystemFont(ofSize: 11)

		let label5 = UILabel()
		label5.translatesAutoresizingMaskIntoConstraints = false
		label5.backgroundColor = UIColor(red: 0.98, green: 0.80, blue: 0.51, alpha: 1.0)
		label5.text = "face83"
		label5.textAlignment = NSTextAlignment.center
		label5.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label6 = UILabel()
		label6.translatesAutoresizingMaskIntoConstraints = false
		label6.backgroundColor = UIColor(red: 0.82, green: 0.80, blue: 0.90, alpha: 1.0)
		label6.text = "d2cce6"
		label6.textAlignment = NSTextAlignment.center
		label6.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label7 = UILabel()
		label7.translatesAutoresizingMaskIntoConstraints = false
		label7.backgroundColor = UIColor(red: 0.80, green: 0.86, blue: 0.27, alpha: 1.0)
		label7.text = "ccdc47"
		label7.textAlignment = NSTextAlignment.center
		label7.font = UIFont.boldSystemFont(ofSize: 11)
		
		let label8 = UILabel()
		label8.translatesAutoresizingMaskIntoConstraints = false
		label8.backgroundColor = UIColor(red: 0.50, green: 0.71, blue: 0.91, alpha: 1.0)
		label8.text = "81b7ea"
		label8.textAlignment = NSTextAlignment.center
		label8.font = UIFont.boldSystemFont(ofSize: 11)
		
		view.addSubview(label1)
		view.addSubview(label2)
		view.addSubview(label3)
		view.addSubview(label4)
		view.addSubview(label5)
		view.addSubview(label6)
		view.addSubview(label7)
		view.addSubview(label8)
		
		constrain(label1, label2, label3, label4, view) {
			(label1, label2, label3, label4, view) in
			let width = view.width*0.5
			let height = view.height*0.25
			let top = view.top
			let left = view.left
			let right = view.right
			
			label1.width == width
			label2.width == width
			label3.width == width
			label4.width == width
			label1.height == height
			label2.height == height
			label3.height == height
			label4.height == height
			
			label1.top == top
			label2.top == top
			label3.top == label1.bottom
			label4.top == label2.bottom
			label1.left == left
			label3.left == left
			label2.right == right
			label4.right == right
		}
		
		constrain(label5, label6, label7, label8, view, replace: nil) {
			(label5, label6, label7, label8, view) in
			let width = view.width*0.5
			let height = view.height*0.25
			let top = view.centerY
			let left = view.left
			let right = view.right
			
			label5.width == width
			label6.width == width
			label7.width == width
			label8.width == width
			label5.height == height
			label6.height == height
			label7.height == height
			label8.height == height
			
			label5.top == top
			label6.top == top
			label7.top == label5.bottom
			label8.top == label6.bottom
			label5.left == left
			label6.right == right
			label7.left == left
			label8.right == right
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
