import Foundation
public struct Heap<T: Comparable> {
    private var elements: [T] = []
    var sortFunction: (T, T) -> Bool
    
    var isEmpty: Bool {
        return self.elements.count <= 1
    }
    var peek: T? {
        if self.isEmpty { return nil }
        return self.elements.last!
    }
    var count: Int {
        return self.elements.count - 1
    }
    
    init(elements: [T] = [], sortFunction: @escaping (T, T) -> Bool) {
        if !elements.isEmpty {
            self.elements = [elements.first!] + elements
        } else {
            self.elements = elements
        }
        self.sortFunction = sortFunction
        if elements.count > 1 {
            self.buildHeap()
        }
    }
    
    private func leftChild(of index: Int) -> Int {
        return index * 2
    }
    
    private func rightChild(of index: Int) -> Int {
        return index * 2 + 1
    }
    
    private func parent(of index: Int) -> Int {
        return (index) / 2
    }
    
    private mutating func add(element: T) {
        self.elements.append(element)
    }
    
    mutating private func diveDown(from index: Int) {
        var higherPriority = index
        let leftIndex = self.leftChild(of: index)
        let rightIndex = self.rightChild(of: index)
        
        if leftIndex < self.elements.endIndex && self.sortFunction(self.elements[leftIndex], self.elements[higherPriority]) {
            higherPriority = leftIndex
        }
        if rightIndex < self.elements.endIndex && self.sortFunction(self.elements[rightIndex], self.elements[higherPriority]) {
            higherPriority = rightIndex
        }
        if higherPriority != index {
            self.elements.swapAt(higherPriority, index)
            self.diveDown(from: higherPriority)
        }
    }
    
    mutating private func swimUp(from index: Int) {
        var index = index
        while index != 1 && self.sortFunction(self.elements[index], self.elements[self.parent(of: index)]) {
            self.elements.swapAt(index, self.parent(of: index))
            index = self.parent(of: index)
        }
    }
    
    mutating private func buildHeap() {
        for index in (1...(self.elements.count / 2)).reversed() {
            self.diveDown(from: index)
        }
    }
    
    mutating func reBuildHeap() {
        if elements.count > 1 {
            for index in (1...(self.elements.count / 2)).reversed() {
                self.diveDown(from: index)
            }
        }
    }
    
    mutating func insert(node: T) {
        if self.elements.isEmpty {
            self.elements.append(node)
        }
        self.elements.append(node)
        self.swimUp(from: self.elements.endIndex - 1)
    }
    
    @discardableResult
    mutating func remove() -> T? {
        if self.isEmpty { return nil }
        self.elements.swapAt(1, elements.endIndex - 1)
        let deleted = elements.removeLast()
        self.diveDown(from: 1)
        
        return deleted
    }
}

public struct DoublePriorityQueue<T: Comparable> {
    public enum HeapSortMode {
        case max
        case min
        
        var sortFunction: (T, T) -> Bool {
            switch self {
            case .max:
                return { $0 > $1 }
            case .min:
                return { $0 < $1 }
            }
        }
        
        mutating func toggle() {
            self = self == .max ? .min : .max
        }
    }
    
    var heap: Heap<T>
    
    var sortMode: HeapSortMode {
        didSet {
            self.heap.sortFunction = sortMode.sortFunction
            self.heap.reBuildHeap()
        }
    }
    
    var isEmpty: Bool {
        return self.heap.isEmpty
    }
    
    var count: Int {
        return self.heap.count
    }
    
    public init(elements: [T] = [], sortMode: HeapSortMode) {
        self.heap = Heap<T>(elements: elements, sortFunction: sortMode.sortFunction)
        self.sortMode = sortMode
    }
    
    mutating func enqueue(node: T) {
        self.heap.insert(node: node)
    }
    
    @discardableResult
    mutating func dequeueMax() -> T? {
        if self.heap.isEmpty { return nil }
        if self.sortMode == .max {
            return self.heap.remove()
        } else {
            self.sortMode.toggle()
            return self.heap.remove()
        }
    }
    
    @discardableResult
    mutating func dequeueMin() -> T? {
        if self.heap.isEmpty { return nil }
        if self.sortMode == .min {
            return self.heap.remove()
        } else {
            self.sortMode.toggle()
            return self.heap.remove()
        }
    }
    
    @discardableResult
    mutating func deqeue() -> T? {
        return self.heap.remove()
    }
}

func solution(_ operations:[String]) -> [Int] {
    var result = [Int]()
    var queue = DoublePriorityQueue<Int>(sortMode: .max)
        
    for operation in operations {
        let operationArr = operation.split(separator: " ")
        let command = operationArr[0]
        let num = Int(operationArr[1])!
        
        switch (command, num) {
        case ("I", _):
            queue.enqueue(node: num)
        case ("D", 1):
            guard !queue.isEmpty else { break }
            queue.dequeueMax()
        case ("D", -1):
            guard !queue.isEmpty else { break }
            queue.dequeueMin()
        default:
            break
        }
    }
    
    if queue.isEmpty {
        return [0, 0]
    }
    
    let num = queue.deqeue()!
    result.append(num)
    
    if queue.isEmpty {
        return [num, num]
    }
        
    queue.sortMode.toggle()
    
    result.append(queue.deqeue()!)
    
    return result.sorted(by: >)
}