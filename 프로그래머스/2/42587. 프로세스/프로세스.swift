import Foundation

func solution(_ priorities:[Int], _ location:Int) -> Int {
    var currentMax = priorities.max()
    var queue = priorities.enumerated().map { ($0, $1) }
    var out: Int = 0
    
    while queue.count > 0 {
        let tuple = queue.removeFirst()
        let index = tuple.0
        let priority = tuple.1
        if priority == currentMax {
            out += 1
            currentMax = queue.max { $0.1 < $1.1 }?.1 ?? -1
            if index == location {
                return out
            }
        } else {
            queue.append(tuple)
        }
        
        
    }
    
    return 0
}