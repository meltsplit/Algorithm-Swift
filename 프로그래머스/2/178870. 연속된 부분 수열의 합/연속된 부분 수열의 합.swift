import Foundation

class LinkedList {
    var head: Node?
    var tail: Node?
    
    func append(_ newNode: Node) {
        if head == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            self.tail = newNode
        }
    }
    
    func removeFirst() {
        self.head = self.head?.next
        if head == nil { tail = nil }
        
    }
}

class Node {
    var value: Int
    var next: Node?
    
    init(value: Int) {
        self.value = value
        self.next = nil
    }
}

func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    
    let linkedList = LinkedList()
    var answer = [(Int, Int)]()
    var stackSum = 0
    
    for index in sequence.indices {
        linkedList.append(Node(value: index))
        stackSum += sequence[index]
        
        while stackSum >= k {
            if stackSum == k {
                answer.append((linkedList.head!.value, linkedList.tail!.value)) 
            } 
            stackSum -= sequence[linkedList.head!.value]
            linkedList.removeFirst()
        } 
    }
    
    answer = answer.sorted { $0.0 < $1.0 }
    answer = answer.sorted { ($0.1 - $0.0) < ($1.1 - $1.0)}
    
    
    return [answer.first!.0, answer.first!.1]
}