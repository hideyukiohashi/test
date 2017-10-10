
import UIKit
import GameKit

class MainViewController: UIViewController {

	@IBOutlet weak var flagButtonA: UIButton!
	@IBOutlet weak var flagButtonB: UIButton!
	@IBOutlet weak var flagButtonC: UIButton!
	
	var countries = [String]()
	var correctAnswer = 0
	var score = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		flagButtonA.layer.borderWidth = 1
		flagButtonB.layer.borderWidth = 1
		flagButtonC.layer.borderWidth = 1
		flagButtonA.layer.borderColor = UIColor.lightGray.cgColor
		flagButtonB.layer.borderColor = UIColor.lightGray.cgColor
		flagButtonC.layer.borderColor = UIColor.lightGray.cgColor
		
		countries = ["estonia", "france", "germany", "ireland", "italy", "japan", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		askQuestion()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	private func askQuestion(action: UIAlertAction! = nil) {
		
		
		countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
		flagButtonA.setImage(UIImage(named: countries[0]), for: .normal)
		flagButtonB.setImage(UIImage(named: countries[1]), for: .normal)
		flagButtonC.setImage(UIImage(named: countries[2]), for: .normal)
		
		correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
		navigationItem.title = countries[correctAnswer].uppercased()
	}

	@IBAction func tappedFlagButton(_ sender: UIButton) {
		var title: String
		
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
		} else {
			title = "Wrong"
			score -= 1
		}
		
		let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(ac, animated: true)
	}
}
