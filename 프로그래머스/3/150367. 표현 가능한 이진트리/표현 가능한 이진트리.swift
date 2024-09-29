import Foundation

// 11:20

// return: 이진트리로 표현할 수 있으면 1 else 0
// depth | leaf | count | range
// 1    |  1    |  1  |  0 - 2^1 - 1
// 2    |  2    |  3  |  0 - 2^3 - 1
// 3    |  4    |  7  |  0 - 2^7 - 1
// 4    |  8    |  15 |  0 - (2^15 - 1)
// 5    |  16    |  31 |  0 - (2^31 - 1)
// 5    |  32    |  63 |  0 - (2^63 - 1)

// n은 표현 가능한가?
// n을 이진트리로 구현했을 때. x 아래에 o가 없는가

// Idea 1:
// 1. n을 이진트리로 구현한다.
// 2. 이진트리를 순회하며 x아래에 o가 없는지 확인

func dfs(_ arr: [String]) -> Bool {
    guard arr.count > 1 else { return true }
    let mid = arr.count / 2
    let left = Array(arr.prefix(mid))
    let right = Array(arr.suffix(mid))
    
    if arr[mid] == "0" {
        guard !left.contains("1") else { return false }
        guard !right.contains("1") else { return false }
    } 
    
    return dfs(left) && dfs(right)
}

func execute(_ n: Int64) -> Bool {
    let n_2 = String(n, radix: 2)
    let digit = getDigit(n)
    let tree = String(repeating: "0", count: digit - n_2.count) + n_2
    return dfs(tree.map{String($0)})
}
    
func getDigit(_ n : Int64) -> Int {
    for i in [1,3,7,15, 31, 63] {
        let max = pow(2.0, Double(i)) - 1.0
        guard Double(n) > max else { return i }
    }
    return 63
}

func solution(_ numbers:[Int64]) -> [Int] {
    let a = Int.max
    let b = pow(2.0, 63.0)
    let c = pow(10.0, 15.0)
    // print(Double(a) > b)
    // print(b > c)
    return numbers.map {
        return execute($0) ? 1 : 0
    }
}