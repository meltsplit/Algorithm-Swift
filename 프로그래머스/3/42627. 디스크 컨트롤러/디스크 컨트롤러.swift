import Foundation

struct Node {
    let id: Int
    let requestTime: Int
    let interval: Int
    
    init(
        _ id: Int,
        _ requestTime: Int,
        _ interval: Int
    ) {
        self.id = id
        self.requestTime = requestTime
        self.interval = interval
    }
    
    static let root = Self(Int.min, Int.min, Int.min)
}

extension Node : Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.interval == rhs.interval 
        else { return lhs.interval > rhs.interval }
        guard lhs.requestTime == rhs.requestTime 
        else { return lhs.requestTime > rhs.requestTime }
        return lhs.id > rhs.id
    }
}
struct Heap {
    
    var elements: [Node]
    
    init () {
        self.elements = [Node.root]
    }
    
    var isEmpty: Bool { elements.count <= 1}
    
    func leftChild(_ index: Int) -> Int {
        index * 2
    }
    
    func rightChild(_ index: Int) -> Int {
        index * 2 + 1
    }
    
    func parent(_ index: Int) -> Int {
        index / 2
    }
    
    mutating func insert(_ node: Node) {
        elements.append(node)
        swimUp(elements.count - 1)
    }
    
    mutating func remove() -> Node? {
        guard !isEmpty else { return nil }
        elements.swapAt(1, elements.count - 1)
        let result = elements.removeLast()
        diveDown(1)
        return result
    }
    
    mutating func diveDown(_ index: Int) {
        var priorityIndex = index
        let leftIndex = leftChild(index)
        let rightIndex = rightChild(index)
        
        
        
        
        if leftIndex < elements.count
        && elements[leftIndex] > elements[priorityIndex] {
            priorityIndex = leftIndex
        }
        
        if rightIndex < elements.count
        && elements[rightIndex] > elements[priorityIndex] {
            priorityIndex = rightIndex
        }
        
        if priorityIndex != index {
            elements.swapAt(priorityIndex, index) 
            diveDown(priorityIndex)
        } 
        
    }
    
    mutating func swimUp(_ index: Int) {
        let parentIndex = parent(index)
        
        if elements[index] > elements[parentIndex] {
            elements.swapAt(index, parentIndex)
            swimUp(parentIndex)
        }
    }
    
    
}

func solution(_ jobs:[[Int]]) -> Int {
    let count = jobs.count
    var jobs = jobs.enumerated().sorted { a, b in a.1[0] > b.1[0] }.map { Node($0, $1[0], $1[1]) }
    var heap = Heap()
    var now = 0
    var answer = 0
    
    while !(jobs.isEmpty && heap.isEmpty) {
        while !jobs.isEmpty {
            let task = jobs.removeLast()
            if task.requestTime <= now  {
                heap.insert(task)
            } else {  
                jobs.append(task)
                break
            }
        }
        
        // 힙에서 값을 꺼낸다.
        if let task = heap.remove() {
            // print("\(now) 일 때 \(task)를 꺼냈습니다.")
            now += task.interval
            let result = now - task.requestTime
            // print("반환 시간: \(now) - \(task.requestTime) = \(result)")
            answer += result
        } else if let targetTime = jobs.last?.requestTime {
            now = targetTime
        }
    }
    
    return answer / count
}