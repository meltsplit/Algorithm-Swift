import Foundation

// 21:00
// return: 최저 예상 요금
func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    
    var graph: [[Int]] = Array(repeating: Array(repeating: Int.max, count: n + 1), count: n + 1)
    
    for fare in fares {
        let c = fare[0]
        let d = fare[1]
        let f = fare[2]
        graph[c][d] = f
        graph[d][c] = f
    }
    
    for i in 1...n {
        graph[i][i] = 0
    }
    
    for k in 1...n {
        for i in 1...n {
            for j in 1...n {
                
                let oldValue = graph[i][j]
                
                guard graph[i][k] != Int.max && graph[k][j] != Int.max 
                else { continue } 
                let newValue = graph[i][k] + graph[k][j]
                graph[i][j] = min(oldValue, newValue)
                graph[j][i] = min(oldValue, newValue)
            }
        }
    }
    for i in 1...n {
        print(graph[i][i])
    }
    return (1...n).map { p in
        let x = graph[s][p]
        let a = graph[p][a]
        let b = graph[p][b]
        guard x != Int.max && a != Int.max && b != Int.max else { return Int.max }
        return x + a + b
    }.min()!
}