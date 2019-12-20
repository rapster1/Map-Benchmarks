import Foundation

class LinearMap<K : Hashable & Comparable, V> : GeneralMap<K, V>{

  var keys: [K] = []
  var values: [V] = []


  override func set(_ k: K,_ v: V) {
    let keyIndex = findKeyIndex(k)
    if keyIndex == nil {
      keys.append(k)
      values.append(v)
    } else { values[keyIndex!] = v }
  }

  override func remove(_ k: K) {
    let keyIndex = findKeyIndex(k)
    if count != 0 && keyIndex != nil {
      keys.remove(at: keyIndex!)
      values.remove(at: keyIndex!)
    }
  }

  override func get(_ k: K) -> V? {
    let keyIndex = findKeyIndex(k)
    if keyIndex != nil && count != 0 {
      return values[keyIndex!]
    } else { return nil }
  }

  func findKeyIndex(_ k: K) -> Int? {
    var index = 0
    for i in keys {
      if i == k {
        return index
      } else { index += 1 }
    }

    return nil
  }

 override var count: Int {return keys.count}

  override var description: String {
    var mapString = "["
    for i in keys {
      mapString += "\n\(i) : \(values[findKeyIndex(i)!])"
    }
    return mapString + "\n]"
  }

  override subscript (index: K) -> V? {
    get {
      return get(index)
    }
    set {
      set(index, newValue!)
    }
  }
}
