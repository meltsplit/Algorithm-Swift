import Foundation

// 최후 가능

// 규칙: 
// 더 작은거 터트리는 건 1번만

// 본질
// 양쪽에 나보다 작은 번호 있으면 불가
// arrA: 왼쪽에 나보다 작은 번호가 없다. == 내가 제일 작다.
// arrB: 오른쪽에 나보다 작은 번호가 없다. == 내가 제일 작다.
// answer: a || b 

// 재정의:
// 0 1 2 3 i
// 1 4 3 2
// 3 2 1 0 j
func solution(_ a:[Int]) -> Int {
    var arrA = Array(repeating: false, count: a.count)
    var arrB = Array(repeating: false, count: a.count)
    var leftMin = Int.max
    var rightMin = Int.max
    
    for i in a.indices { 
        let now = a[i]
        if now < leftMin { 
            arrA[i] = true 
            leftMin = now
        }
        
        let j = a.count - 1 - i
        let nowJ = a[j]
        if nowJ < rightMin {
            arrB[j] = true
            rightMin = nowJ
        }
    }
    
    return a.indices.filter { arrA[$0] || arrB[$0] }.count
}