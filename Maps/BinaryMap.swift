import Foundation

class BinaryMap<K : Hashable & Comparable, V> : GeneralMap<K, V> {
  var keys: [K] = []
  var values: [V] = []

 override func set(_ k: K,_ v: V) {
    let keyIndex = binarySearch(elements: keys, target: k)
    if count == 0 || k > keys[count - 1] {
      keys.append(k)
      values.append(v)
    } else if keyIndex != nil {
      values[keyIndex!] = v
    } else {
      var i = 0
      while k > keys[i] {
        i += 1
      }
      keys.insert(k, at: i)
      values.insert(v, at: i)
    }
  }

 override func remove(_ k: K) {
    let keyIndex = binarySearch(elements: keys, target: k)
    if count != 0 && keyIndex != nil {
      keys.remove(at: keyIndex!)
      values.remove(at: keyIndex!)
    }
  }

  override func get(_ k: K) -> V? {
    let keyIndex = binarySearch(elements: keys, target: k)
    if keyIndex != nil && count != 0 {
      return values[keyIndex!]
    } else { return nil }
  }

  func binarySearch<K: Comparable>(elements:[K], target: K) -> Int? {
      var lowerIndex = 0;
      var upperIndex = elements.count - 1
      if count != 0 {
        while (true) {
            let currentIndex = (lowerIndex + upperIndex)/2
            if(elements[currentIndex] == target) {
                return currentIndex
            } else if (lowerIndex > upperIndex) {
                return nil
            } else {
                if (elements[currentIndex] > target) {
                    upperIndex = currentIndex - 1
                } else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
      } else { return nil }
  }

 override var count: Int {return keys.count}

 override var description: String {
    var mapString = "["
    for i in keys {
      mapString += "\n\(i) : \(values[binarySearch(elements: keys, target: i)!])"
    }
    return mapString + "\n]"
  }

 override subscript (index: K) -> V? {
    get {
      return get(index)
    }
    set(newValue) {
      set(index,newValue!)
    }
  }
}
