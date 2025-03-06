import Foundation

class Queue {
    var elements = [Int]()
    var firstIndex = 0
    var isEmpty: Bool { elements.count <= firstIndex }
    
    func enqueue(_ id: Int) {
        elements.append(id)
    }
    
    func dequeue() -> Int? {
		    guard !isEmpty else { return nil }
		    let temp = elements[firstIndex]
		    firstIndex += 1
				return temp
    }
}

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    
    var graph: [Int: [Int]] = [:]
    var distance = Array(repeating: -1, count: n + 1)
    for e in edge {
        graph[e[0], default: []].append(e[1])
        graph[e[1], default: []].append(e[0])
    }
    
    distance[1] = 0
    
    func bfs() {
        var queue = Queue()
        queue.enqueue(1)
        while !queue.isEmpty {
            let now = queue.dequeue()!
            
            graph[now, default: []].forEach {
                if distance[$0] == -1 {
                    distance[$0] = distance[now] + 1
                    queue.enqueue($0)
                }
            }
        }
    }
    
    bfs()
    let maxValue = distance.max()!
    return distance.filter { $0 == maxValue}.count
}