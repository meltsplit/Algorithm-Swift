import Foundation

// 1632
// return: 최단시간

struct Queue {
    
    var elements = [Int]()
    var firstIndex = 0
    
    var isEmpty: Bool { firstIndex >= elements.count }
    
    mutating func append(_ element: Int) {
        elements.append(element)
    }
    
    mutating func remove() -> Int? {
        guard !isEmpty else { return nil }
        let result = elements[firstIndex]
        firstIndex += 1
        return result
    }
}

func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination:Int) -> [Int] {
    
    var graph = [Int: [Int]]()
    
    for i in 1...n {
        graph[i] = []
    }
    
    for road in roads {
        graph[road[0]]!.append(road[1])
        graph[road[1]]!.append(road[0])
    }
    
    var distances = Array(repeating: -1, count: n + 1)
    distances[destination] = 0
    
    func bfs() {
        var queue = Queue()
        queue.append(destination)
        
        while !queue.isEmpty {
            guard let now = queue.remove() else { break }
            let nexts = graph[now]!
            
            for next in nexts {
                guard distances[next] == -1 else { continue } // -1 이여야 미방문 노드
                distances[next] = distances[now] + 1
                queue.append(next)
            }
        }
    }
    
    bfs() 
    return sources.map { distances[$0] }
}