import Foundation

// 1432
// return: 가장 긴 스타 수열 길이

// 이분탐색 
// isPossible(x): x길이의 스타수열이 존재하는가?
// TTTFFFFFFFFFF
// return low

// isPossible(x)
// 배열에 최대 중복 원소수가 x쌍 이상인가?
// pair는 stack 활용

// a[0] 이 들어가지 않을 경우
// a[0] == target
// 12, 13, 14, 11

func solution(_ a:[Int]) -> Int {
    
    var dict: [Int: Int] = [:]
    var answer = Int.min
    var stack: [Int] = []
    
    for element in a {
        dict[element, default: 0] += 1
    }
    
    
    for (target, count) in dict {
        guard count * 2 >= answer else { continue }
        
        stack = [a[0]]
        for i in a.indices { 
            guard i != 0 else { continue }
            let element = a[i]

            if stack.count % 2 == 0 { // 짝수일 때
                stack.append(element)
            } else { // 홀수 일때
                if stack.last! != target && element == target {
                    stack.append(element)
                } else if stack.last! == target && element != target {
                    stack.append(element)
                }
            }
        }
        
        answer = max(answer, stack.count % 2 == 0 ? stack.count : stack.count - 1)
        
    
    }
 
    return answer
}