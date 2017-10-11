
import GameKit
import UIKit

class ContentTableViewController: UITableViewController {
	var allowWords = [String]()
	var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer(sender:)))
		
		if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
			if let startWords = try? String(contentsOfFile: startWordsPath) {
				allowWords = startWords.components(separatedBy: "\n")
			}
		} else {
			allowWords = ["Mac"]
		}
		
		startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		return cell
	}
	
	private func startGame() {
		allowWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allowWords) as! [String]
		navigationItem.title = allowWords[0]
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}

	@objc private func promptForAnswer(sender: UIBarButtonItem) {
		let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
		ac.addTextField()
		let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
			let answer = ac.textFields![0]
			self.submit(answer: answer.text!)
		}
		ac.addAction(submitAction)
		present(ac, animated: true, completion: nil)
	}

	private func submit(answer: String) {
		let lowerAnswer = answer.lowercased()
		let errorTitle: String
		let errorMessage: String
	
		if isPossible(word: lowerAnswer) {
			if isOriginal(word: lowerAnswer) {
				if isReal(word: lowerAnswer) {
					usedWords.insert(answer, at: 0)
					let indexPath = IndexPath(row: 0, section: 0)
					tableView.insertRows(at: [indexPath], with: .automatic)
					return
				} else {
					errorTitle = "Misspelling"
					errorMessage = "You can't just make them up, you know!"
				}
			} else {
				errorTitle = "Used Word"
				errorMessage = "Be more original!"
			}
		} else {
			errorTitle = "Not Include Characters"
			errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
		}
		
		let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(ac, animated: true, completion: nil)
	}
	
	/**
	Utilities
	*/

	// not include characters
	private func isPossible(word: String) -> Bool {
		var tempWord = navigationItem.title!.lowercased()
		for letter in word.characters {
			if let pos = tempWord.range(of: String(letter)) {
				tempWord.remove(at: pos.lowerBound)
			} else {
				return false
			}
		}
		return true
	}
	
	// used word
	private func isOriginal(word: String) -> Bool {
		return !usedWords.contains(word)
	}
	
	// misspelling
	private func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSMakeRange(0, word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
		return misspelledRange.location == NSNotFound
	}
}
