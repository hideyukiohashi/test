//: Playground - noun: a place where people can play

import UIKit

var photos = [String]()

let fm = FileManager.default
let path = Bundle.main.resourcePath
let items = try! fm.contentsOfDirectory(atPath: path)

for item in items {
  if item.hasPrefix("cereal") {
    photos.append(item)
  }
}
print("\(photos)")
