import Foundation

struct MinHeap<Element: Comparable> {
    var elements: [Element] = []

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(of: child)

        while child > 0 && elements[child] < elements[parent] {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }

    mutating func pop() -> Element? {
        guard !isEmpty else {
            return nil
        }

        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        siftDown(from: 0)
        return element
    }

    mutating func siftDown(from index: Int) {
        var parent = index

        while true {
            let leftChild = leftChildIndex(of: parent)
            let rightChild = rightChildIndex(of: parent)
            var candidate = parent

            if leftChild < count && elements[leftChild] < elements[candidate] {
                candidate = leftChild
            }

            if rightChild < count && elements[rightChild] < elements[candidate] {
                candidate = rightChild
            }

            if candidate == parent {
                return
            }

            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }

    func leftChildIndex(of index: Int) -> Int {
        return index * 2 + 1
    }

    func rightChildIndex(of index: Int) -> Int {
        return index * 2 + 2
    }
}

func solution(_ jobs:[[Int]]) -> Int {
    
    var waits = jobs.sorted { $0[0] < $1[0] }
    print(waits)
    var able: [[Int]] = []
    var time = 0
    var answer: [Int] = []
    
    while !waits.isEmpty || !able.isEmpty { // 반복 wait와 able 모두 사라질때까지
        
        
        while !waits.isEmpty {
            let requestAt = waits.first![0]
            let takes = waits.first![1]
            
            if requestAt <= time {
                // print("뽑은 시점: \(requestAt)")
                waits.removeFirst()
                able.append([requestAt, takes])
            } else {
                // print("흥흥")
                break
            }
        }
        
        // print("able은 \(able)")
        able = able.sorted { $0[1] < $1[1] }
        // print("정렬된 able은 \(able)")
        
        if !able.isEmpty {
            time += able.first![1]
            answer.append(time-able.first![0])
            able.removeFirst()
        } else {
            time += 1    
        }
        
    }   
    
    return answer.reduce(0, +) / answer.count
}