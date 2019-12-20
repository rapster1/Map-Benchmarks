import Foundation

class GeneralMap<K : Hashable, V>: CustomStringConvertible {
  func getNumberCollisions() -> Int {return 0}
  func set(_ k: K,_ v: V) {return}
  func remove(_ k: K) {return}
  func get(_ k: K) -> V? {return nil}
  var count: Int {return 0}
  subscript(index: K) -> V? {return nil}
  var description: String {return "Fake Map!"}
}
