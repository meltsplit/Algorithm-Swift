import Foundation

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    var winGraph: [Int:[Int]] = [:]
    var loseGraph: [Int:[Int]] = [:]
    
    for i in 1...n { 
        winGraph[i] = [] 
        loseGraph[i] = []
    }
    
    for result in results {
        winGraph[result[0]]!.append(result[1])
        loseGraph[result[1]]!.append(result[0])
    }
    
    func dfs(_ graph: [Int:[Int]],_ target: Int) -> Int {
        var visited = Array(repeating: false, count: n+1)
        var stack: [Int] = []
        var count = 0
        
        stack.append(target)
        visited[target] = true
        
        while !stack.isEmpty {
            let top = stack.removeLast()
            
            let nexts = graph[top]!
            for next in nexts {
                guard !visited[next] else { continue }
                visited[next] = true
                count += 1
                stack.append(next)
            }
        }
        
        return count
        
    }
    
    var answer = 0
    for i in 1...n {
        let winCount = dfs(winGraph,i)
        let loseCount = dfs(loseGraph,i)
        if winCount + loseCount == n-1 {
            answer += 1 
        }
        
    }
    
    return answer
}