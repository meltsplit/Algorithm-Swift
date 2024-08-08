import Foundation

// 19 00

// collatz 그래프를 어떻게 그릴 것 인가
// 정적분 어떻게 할 것 인가

func collatz(_ x: Int, _ result: [Int]) -> [Int] { 
    let result = result + [x]
    guard x != 1 else { return result }
    let nextX = x % 2 == 0 ? x / 2 : x * 3 + 1
    return collatz(nextX, result)
}

func integral(_ y: [Int]) -> Double {
    var result: Double = 0
    for i in 0..<y.count - 1 {
        let a = Double(y[i])
        let b = Double(y[i + 1])
        result += (a + b) / 2
    }
    return result
}

func solution(_ k:Int, _ ranges:[[Int]]) -> [Double] {
    let results = collatz(k, [])
    return ranges.map { range in
        let startIndex = range[0]
        let endIndex = results.count + range[1]
        guard startIndex < endIndex else { return -1.0 }
        return integral(Array(results[startIndex..<endIndex]))
    }
}