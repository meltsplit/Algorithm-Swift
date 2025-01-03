import Foundation

// e: 5,000,000
// s <= e
// return: 억억단에서 가장 많이 등장한 수

// 이분탐색
// isPossible(x): x개까지 곱셈 있는 것이 range 내에 있는가?
// 2222

func solution(_ e:Int, _ starts:[Int]) -> [Int] {
    
    var count = Array(repeating: 0, count: e+1) // count[i]는 i의 약수의 개수
    var answers = Array(repeating: 0, count: e+1)
    
    
    for i in 1...e {
        for j in 1...e/i {
            count[i*j] += 1
        }
    }
    
    // let sMin = starts.min()!
    var maxV = Int.min
    var maxIndex = -1
    
    for i in (1...e).reversed() {
        let value = count[i]
        if value >= maxV {
            maxV = value
            maxIndex = i
        }
        answers[i] = maxIndex
    }
    
    return starts.map { answers[$0] }
}