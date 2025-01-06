import Foundation

func solution(_ n:Int, _ lighthouse:[[Int]]) -> Int {
    
    var graph: [Int: Set<Int>] = [:]
    
    for l in lighthouse {
        graph[l[0], default: Set<Int>()].insert(l[1])
        graph[l[1], default: Set<Int>()].insert(l[0])
    }
    
    var lighted = Set<Int>()
    var visited = Set<Int>()
    
    func dfs(_ node: Int) {

        visited.insert(node)
        
        for next in graph[node] ?? [] {
            guard !visited.contains(next) 
            else { continue }
            
            dfs(next)
            
            if !(lighted.contains(node) || lighted.contains(next)) {
                lighted.insert(node)
            }
        }
        
    }
    
    dfs(1)
    
    
    return lighted.count
}
