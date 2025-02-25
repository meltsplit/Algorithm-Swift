import Foundation
// 11:54

// return: b팀 승점 최댓값
func solution(_ a:[Int], _ b:[Int]) -> Int {
    var a = a.sorted()
    var b = b.sorted()
    var answer = 0
    
    var j = 0
    
    for i in a.indices {
        while j < b.count {
            if b[j] > a[i] {
                answer += 1
                j += 1
                break
            }
            j += 1
        }
    }
    
    return answer
}