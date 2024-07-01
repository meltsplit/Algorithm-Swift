import Foundation

func solution(_ arr: [String]) -> Int {
    let joinedArr = arr.joined()
    let arrs = joinedArr.split(separator: "-").map { String($0) }
    let val0 = arrs[0].split(separator: "+").map { Int($0)! }.reduce(0, +)
    
    if arrs.count == 1 {
        return val0
    }
    
    var minVal = 0
    var maxVal = 0
    
    for arr in arrs[1...].reversed() {
        let x = arr.split(separator: "+").map { Int($0)! }
        let _minVal = -x.reduce(0, +)
        let _maxVal = x.dropFirst().reduce(0, +) - x.first!
        let newMinVal = min(_minVal + minVal, _minVal - maxVal)
        let newMaxVal = max(_maxVal + maxVal, _minVal - minVal)
        minVal = newMinVal
        maxVal = newMaxVal
    }
    
    return val0 + maxVal
}
