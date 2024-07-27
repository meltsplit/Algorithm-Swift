import Foundation

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    let sum1 = queue1.reduce(0,+)
    let sum2 = queue2.reduce(0,+)
    let totalSum = sum1 + sum2
    guard totalSum % 2 == 0 else { return -1 }
    let target = totalSum / 2
    
    var answer = 0
    
    var arr = queue1 + queue2
    
    var start = 0
    var end = queue1.count - 1
    var sum = sum1
    
    while true {
        if sum == target {
            return answer
        }
        
        if sum < target {
            end += 1
            guard end < arr.count else { break }
            sum += arr[end]
        } else {
            sum -= arr[start]
            start += 1
        }
        answer += 1
    }
    return -1
}

// s를 맨앞으로 오게 하는 거리 + 