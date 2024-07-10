import Foundation

// 1번에서 DFS 
// 방문시 depth를 저장

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    var maxDepth = 0
    var answer = 0
    
    var graph: [Int: Set<Int>] = [:]
    var visited = Array(repeating: false, count: n+1)
    
    for i in 1...n {
        graph[i] = []
    }
    
    for e in edge {
        let a = e[0]
        let b = e[1]
        
        graph[a]!.insert(b)
        graph[b]!.insert(a)
    }
    
    
    func bfs( _ visited: inout [Bool]) {
        var queue = [(Int,Int)]()
        
        queue.append((0,1))
        visited[1] = true
        
        while !queue.isEmpty {
                
            let (depth,now) = queue.removeFirst()
            if depth == maxDepth { 
                answer += 1 
            }  else if depth > maxDepth {
                maxDepth = depth
                answer = 1
        }
            
            for next in graph[now]! {
                guard !visited[next] else { continue }
                visited[next] = true
                queue.append((depth + 1,next))
            }
            
        }
        
    }
    
    bfs(&visited)
    return answer
}

// func dfs(_ now: Int, _ depth: Int, _ visited: inout [Bool]) {
//         print(now, "방문했습니다 깊이는",depth)
//         if depth == maxDepth { answer += 1 } 
//         else if depth > maxDepth {
//             maxDepth = depth
//             answer = 1
//         }
        
//         for n in graph[now]! {
//             guard !visited[n] else { continue }
//             visited[n] = true
//             dfs(n, depth + 1, &visited)
//             visited[n] = false
//         }
//     }
    