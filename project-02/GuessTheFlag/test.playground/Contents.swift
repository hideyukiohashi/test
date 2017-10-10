//: Playground - noun: a place where people can play

import UIKit

/**
Array: Shuffle and Shuffled
*/

extension Array {
	mutating func shuffle() {
		for i in 0 ..< self.count {
			let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
			if i != j {
				self.swapAt(i, j)
			}
		}
	}
	
	var shuffled: Array {
		var copied = Array<Element>(self)
		copied.shuffle()
		return copied
	}
}

var arr1: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
arr1.shuffle()
print(arr1)
arr1.shuffle()
print(arr1)

let arr2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
print(arr2.shuffled)
print(arr2.shuffled)
print(arr2)
