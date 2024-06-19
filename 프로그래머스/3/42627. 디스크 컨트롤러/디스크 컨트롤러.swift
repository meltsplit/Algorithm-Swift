import Foundation

func solution(_ jobs:[[Int]]) -> Int {
    
    var waits = jobs.sorted { $0[0] < $1[0] }
    print(waits)
    var able: [[Int]] = []
    var time = 0
    var answer: [Int] = []
    
    while !waits.isEmpty || !able.isEmpty { // 반복 wait와 able 모두 사라질때까지
        
        
        while !waits.isEmpty {
            let requestAt = waits.first![0]
            let takes = waits.first![1]
            
            if requestAt <= time {
                // print("뽑은 시점: \(requestAt)")
                waits.removeFirst()
                able.append([requestAt, takes])
            } else {
                // print("흥흥")
                break
            }
        }
        
        // print("able은 \(able)")
        able = able.sorted { $0[1] < $1[1] }
        // print("정렬된 able은 \(able)")
        
        if !able.isEmpty {
            time += able.first![1]
            answer.append(time-able.first![0])
            able.removeFirst()
        } else {
            time += 1    
        }
        
    }   
    
    return answer.reduce(0, +) / answer.count
}
