import Foundation

class Node {
    let id: Int
    var next: Node?
    var prev: Node?
    
    init(id: Int) {
        self.id = id
    }
}

class Queue {
    
    var head: Node?
    var tail: Node?
    
    var isEmpty: Bool { head == nil || tail == nil }
    
    func enqueue(_ id: Int) {
        let node = Node(id: id)
        if isEmpty {
            head = node
            tail = node
        } else {
            tail?.next = node
            node.prev = tail
            tail = node
        }
    }
    
    func dequeue() -> Int? {
        guard !isEmpty else { return nil }
        let temp = head
        let newHead = temp?.next
        self.head = newHead
        newHead?.prev = nil
        return temp?.id
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        var log = ""
        var node = head
        while node != nil {
            log += " \(node!.id)"
            node = node!.next
        }
        return log
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