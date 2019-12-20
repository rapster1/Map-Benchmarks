import Foundation

class HashMap<K : Hashable & Comparable, V> : GeneralMap<K, V> {
  var keys: [K?]
  var values: [V?]
  var collisionMap = LinearMap<K, V>()
  var numberCollisions = 0

   override var count: Int {
        var numbers = 0
        for i in keys {
            if i != nil {numbers += 1}
        }
        return numbers
    }
    
  init (initialArraySize: Int = 2000) {
    self.keys = Array(repeating: nil, count: initialArraySize)
    self.values = Array(repeating: nil, count: initialArraySize)
  }

  override func getNumberCollisions() -> Int {
    return numberCollisions
  }

 override func set(_ k: K,_ v: V) {
    let keyIndex = abs(k.hashValue%keys.count)
    if keys[keyIndex] == k {
      values[keyIndex] = v
    } else if keys[keyIndex] != nil && keys[keyIndex] != k {
      collisionMap[k] = v
      numberCollisions += 1
    } else {
      keys[keyIndex] = k
      values[keyIndex] = v
    }
  }

 override func get(_ k: K) -> V? {
    let keyIndex = abs(k.hashValue%keys.count)
    if keys[keyIndex] == k {
      return values[keyIndex]
    } else if keys[keyIndex] != nil && keys[keyIndex] != k {
      numberCollisions += 1
      return collisionMap[k]
    } else { return nil }
  }

 override var description: String {
    var mapString = "["
    for i in keys {
      if i != nil {
        mapString += "\n\(i!) : \(values[abs(i!.hashValue%keys.count)]!)"
      }
    }
    for i in collisionMap.keys {
      mapString += "\n\(i) : \(collisionMap[i]!)"
    }
    return mapString + "\n]"
  }

 override subscript (index: K) -> V? {
    get {
      return get(index)
    }
    set(newValue) {
      set(index, newValue!)
    }
  }
}
