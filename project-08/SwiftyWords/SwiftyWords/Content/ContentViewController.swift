
import GameplayKit
import UIKit

class ContentViewController: UIViewController {
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var cluesLabel: UILabel!
	@IBOutlet weak var answersLabel: UILabel!
	@IBOutlet weak var currentTextField: UITextField!
	
	var letterButtons = [UIButton]()
	var activatedButton = [UIButton]()
	var solutions = [String]()
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	var level = 1
	
	override func viewDidLoad() {
        super.viewDidLoad()

		cluesLabel.numberOfLines = 0
		answersLabel.numberOfLines = 0
		
		for subview in view.subviews where subview.tag == 1000 {
			for subview2 in subview.subviews where subview2.tag == 1001 {
				for subview3 in subview2.subviews where subview3.tag == 1002 {
					let btn = subview3 as! UIButton
					letterButtons.append(btn)
					btn.addTarget(self, action: #selector(tappedLetter(sender:)), for: .touchUpInside)
				}
			}
		}
		
		loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	private func loadLevel() {
		var clueString = ""
		var solutionString = ""
		var letterBits = [String]()
		
		if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
			if let levelContents = try? String(contentsOfFile: levelFilePath) {
				var lines = levelContents.components(separatedBy: "\n")
				lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
				
				for (index, line) in lines.enumerated() {
					let parts = line.components(separatedBy: ": ")
					let answer = parts[0]
					let clue = parts[1]
	
					clueString += "\(index + 1). \(clue)\n"
					
					let solutionWord = answer.replacingOccurrences(of: "|", with: "")
					solutionString += "\(solutionWord.count) letters\n"
					solutions.append(solutionWord)
					
					let bits = answer.components(separatedBy: "|")
					letterBits += bits
				}
			}
		}
		
		cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
		answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
		
		letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
		if letterBits.count == letterButtons.count {
			for i in 0 ..< letterButtons.count {
				letterButtons[i].setTitle(letterBits[i], for: .normal)
			}
		}
	}
	
	@objc private func tappedLetter(sender: UIButton) {
		currentTextField.text = currentTextField.text! + sender.titleLabel!.text!
		activatedButton.append(sender)
		sender.isEnabled = false
	}
	
	@IBAction func tappedSubmit(_ sender: UIButton) {
		if let solutionPosition = solutions.index(of: currentTextField.text!) {
			activatedButton.removeAll()
			
			var splitAnswers = answersLabel.text!.components(separatedBy: "\n")
			splitAnswers[solutionPosition] = currentTextField.text!
			answersLabel.text = splitAnswers.joined(separator: "\n")
			
			currentTextField.text = ""
			score += 1
			
			if score%7 == 0 {
				let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
				present(ac, animated: true, completion: nil)
			}
		}
	}

	@IBAction func tappedClear(_ sender: UIButton) {
		currentTextField.text = ""
		for btn in activatedButton {
			btn.isEnabled = true
		}
		activatedButton.removeAll()
	}
	
	private func levelUp(action: UIAlertAction) {
		level += 1
		solutions.removeAll(keepingCapacity: true)
		loadLevel()
		for btn in letterButtons {
			btn.isEnabled = true
		}
	}
}
