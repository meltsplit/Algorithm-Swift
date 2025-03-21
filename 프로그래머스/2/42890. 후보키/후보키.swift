import Foundation

// 1215

// return: 후보키 개수

func solution(_ relation:[[String]]) -> Int {
    var answer = Set<Set<Int>>()
    
    func bfs() {
        var queue = [[Int]]()
        
        for i in 0..<relation[0].count {
            queue.append([i])
        }
        
        while !queue.isEmpty {
            let now = queue.removeFirst()
            let able = answer.allSatisfy { !$0.isSubset(of: now) }
            guard able else { continue }
            let uniqueValues =  Set(relation.map { row in now.reduce("") { "\($0)|\(row[$1])"}})
            if uniqueValues.count == relation.count {
                
                answer.insert(Set(now))
                continue
            }
            
            let lastValue = now.last!
            for i in (lastValue + 1)..<relation[0].count {
                queue.append(now + [i])
            }
        }
        
    }
    
    bfs()
    return answer.count
}