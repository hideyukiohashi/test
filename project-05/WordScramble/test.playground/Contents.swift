//: Playground - noun: a place where people can play

import UIKit


var allowWords = ["Mac", "iPad", "iPhone", "Watch", "TV"]
var usedWords = [String]()

var title = allowWords[0]
let word = "principle";

private func isReal(word: String) -> Bool {
	let checker = UITextChecker()
	let range = NSMakeRange(0, word.utf16.count)
	let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
	return misspelledRange.location == NSNotFound
}

let p = isReal(word: word)
print("\(p)")
