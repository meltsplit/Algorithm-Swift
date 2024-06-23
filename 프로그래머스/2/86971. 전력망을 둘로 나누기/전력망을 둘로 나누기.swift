import Foundation

func solution(_ n:Int, _ wires:[[Int]]) -> Int {
    
    var matrix: [[Int]] = Array(repeating: [Int](), count: n + 1)
    var visited: [Bool] = Array(repeating: false, count: n + 1)
    var answer = n
    
    for i in wires.indices {
        let wire = wires[i]
        matrix[wire[0]].append(wire[1])    
        matrix[wire[1]].append(wire[0])  
    }
    
    func bfs(_ start: Int) -> Int {
        
        var queue: [Int] = [start]
        visited[start] = true

        while !queue.isEmpty {
            let node = queue.removeFirst()

            for adj in matrix[node] {
                guard !visited[adj] else { continue }

                queue.append(adj)
                visited[adj] = true

            }
        }

        return visited.filter { $0 }.count
    }
    
    visited = Array(repeating: false, count: n + 1)
    visited[1] = true
    var count = bfs(2) - 1
    answer = abs(count - (n - count))
        
    for i in 1...n {
        visited = Array(repeating: false, count: n + 1)
        visited[i] = true
        // print("\(i)를 방문 처리 후 시작")
        count = bfs(1) - 1
        // print("count: \(count), n: \(n), abs: \(abs(count - (n - count)))")
        answer = min(abs(count - (n - count)),answer)
    }
    
    return answer
}