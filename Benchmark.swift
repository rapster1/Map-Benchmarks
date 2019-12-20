import Foundation

func getCurrentTime() -> Double {
    let cpuTime = clock()
    return (Double(cpuTime))
}

class BenchMark {
    var LinearSet = [Double]()
    var BinarySet = [Double]()
    var HashSet = [Double]()
    var LinearGet = [Double]()
    var BinaryGet = [Double]()
    var HashGet = [Double]()
    var stringList = [String]()
    let chars = Array("abcdefghijklmnopqrstuvwxyz")
    var startCputTime: Double = 0
    var endCpuTime: Double = 0
    var numberOperations = 2000
    
    func startTimer() {
        startCputTime = getCurrentTime()
    }
    func stopTimer() {
        endCpuTime = getCurrentTime()
    }
    func cpuTime() -> Double {
        return (endCpuTime - startCputTime)/1000.0
    }
    
    func getRandomInt(range: Int) -> Int {
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    func makeString(length: Int)-> String {
        var s = ""
        let numberChars = chars.count
        for _ in 0..<length {
            s.append(chars[getRandomInt(range: numberChars)])
        }
        return s
    }
    
    func makeStringList(size: Int) {
        stringList = [String]()
        for _ in 0..<size {
            stringList.append(makeString(length: 10))
        }
    }
    
    func initialize() {
        makeStringList(size: numberOperations * 100)
    }
    
    func randomIntArray() -> [Int] {
        var numbers = [Int]()
        for _ in 0...numberOperations {
            numbers.append(Int.random(in: 0..<numberOperations * 100))
        }
        return numbers
    }
    
    var LMap = LinearMap<String, String>()
    var BMap = BinaryMap<String, String>()
    var HMap = HashMap<String, String>(initialArraySize: 100000000)
    
    func LinearTest() {
        let index = randomIntArray()
        startTimer()
        for i in index {
            LMap.set(stringList[i], stringList[i])
        }
        stopTimer()
        
        LinearSet.append(cpuTime())
        
        startTimer()
        for i in index {
            LMap.get(stringList[i])
        }
        stopTimer()
        
        LinearGet.append(cpuTime())
    }
    
    func BinaryTest() {
        let index = randomIntArray()
        
        startTimer()
        for i in index {
            BMap.set(stringList[i], stringList[i])
        }
        stopTimer()
        
        BinarySet.append(cpuTime())
        
        startTimer()
        for i in index {
            BMap.get(stringList[i])
        }
        stopTimer()
        
        BinaryGet.append(cpuTime())
    }
    
    func HashTest() {
        let index = randomIntArray()
        
        startTimer()
        for i in index {
            HMap.set(stringList[i], stringList[i])
        }
        stopTimer()
        
        HashSet.append(cpuTime())
        
        startTimer()
        for i in index {
            HMap.get(stringList[i])
        }
        stopTimer()
        
        HashGet.append(cpuTime())
    }
    
    func Test(_ map: GeneralMap<String, String>) {
        if map is LinearMap {LinearTest()}
        if map is BinaryMap {BinaryTest()}
        if map is HashMap {HashTest()}
    }
}

func doTest() {
    let Test = BenchMark()
    Test.initialize()
    print ("Linear Test")
    for i in 1...10 {
        let amountOperations = i * Test.numberOperations
        Test.LinearTest()
        print("***************************** \nGet \(amountOperations) : \(Test.LinearGet[i - 1]) Milliseconds")
        print("Set \(amountOperations) : \(Test.LinearSet[i - 1]) Milliseconds")
    }
    print("Binary Test")
    for i in 1...10 {
        let amountOperations = i * Test.numberOperations
        Test.BinaryTest()
        print("***************************** \nGet \(amountOperations) : \(Test.BinaryGet[i - 1]) Milliseconds")
        print("Set \(amountOperations) : \(Test.BinarySet[i - 1]) Milliseconds")
    }
    print("Hash Test")
    for i in 1...10 {
        let amountOperations = i * Test.numberOperations
        Test.HashTest()
        print("***************************** \nGet \(amountOperations) : \(Test.HashGet[i - 1]) Milliseconds")
        print("Set \(amountOperations) : \(Test.HashSet[i - 1]) Milliseconds")
    }
}
