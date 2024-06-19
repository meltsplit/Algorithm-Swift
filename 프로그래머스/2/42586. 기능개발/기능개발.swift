import Foundation

func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    let days = zip(progresses,speeds)
                .map { Int(ceil(Double(100 - $0) / Double($1))) }
    
    var answer: [Int] = []
    var max = -1
    var i = -1
    
    for d in days {
        if d > max {
            max = d
            answer.append(1)
            i += 1
        } else {
            answer[i] += 1
        }
        
    }
    return answer
}