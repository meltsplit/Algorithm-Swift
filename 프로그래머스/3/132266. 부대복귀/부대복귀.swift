import Foundation 

func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination:Int) -> [Int] {
    var graph = [Int: [Int]]()
    
    for road in roads {
        graph[road[0], default: []].append(road[1])
        graph[road[1], default: []].append(road[0])
    }
    
    var distance = Array(repeating: -1, count: n+1) // i 번째 지역에서 destination 까지의 최단 거리, 이 값은 destination에서 i번째 지역까지의 최단 거리로 생각 가능
    distance[destination] = 0
    
    bfs(destination, graph, &distance)
    
    return sources.map { distance[$0] }
}

func bfs(_ destination: Int, _ graph: [Int: [Int]], _ distance: inout [Int]) {
    var queue = [Int]()
    queue.append(destination)
    
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        let nextNodes = graph[cur, default: []]
        
        for node in nextNodes {
            guard distance[node] == -1 else { continue }
            distance[node] = distance[cur] + 1
            queue.append(node)
        }
    }
}
