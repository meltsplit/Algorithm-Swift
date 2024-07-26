import Foundation
func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    
    var answer = [Int]()
    
    var start = 0
    var end = 0
    var sum = sequence[start]
    
    while true {
        if sum == k {
            let newAnswer = [start, end ]
            
            if answer.isEmpty {
                answer = newAnswer
            } else {
                if end - start < answer[1] - answer[0] {
                    answer = newAnswer
                } else if start < answer[0] {
                    answer = newAnswer
                }
            }
        }
        
        
        if sum <= k {
            end += 1
            guard end < sequence.count else { break }
            sum += sequence[end]
        } else {
            sum -= sequence[start]
            start += 1
        }
    }
    
    return answer
}
