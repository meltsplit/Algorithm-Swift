import Foundation


// return: 네트워크 개수

// Idea 1: dfs
// 방문 처리 하면서, 노드가 끝났을 때 answer + 1
// O(n ^ 2)
func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var visited = Set<Int>()
    var answer = 0
    
    func dfs(_ now: Int, _ visited: inout Set<Int>) {
        guard !visited.contains(now) else { return } 
        visited.insert(now)
        for i in computers[now].indices {
            guard i != now && computers[now][i] == 1 else { continue }
            dfs(i, &visited)
        }
    }
    
        
    for i in computers.indices {
        guard !visited.contains(i) else { continue }
        answer += 1
        dfs(i, &visited)
    }
    
    return answer
}