import Foundation
// 1845

// nodeInfo: 
// return : 후위순회 결과

class BST {
    var root: Node?
    
    init() {}
    
    func insert(_ index: Int, _ x: Int) {
        let newNode = Node(index: index, x: x)
        self.root = insert(at: root, newNode)
    }
    
    private func insert(at oldNode: Node?, _ newNode: Node) -> Node {
        guard let oldNode = oldNode else { return newNode }
        
        if newNode.x < oldNode.x {
            oldNode.left = insert(at: oldNode.left, newNode)
        } else {
            oldNode.right = insert(at: oldNode.right, newNode)
        }
        return oldNode
    }
    
    func preOrder() -> [Int] {
        var result = [Int]()
        preOrder(root, &result)
        return result
    }
    
    private func preOrder(_ node: Node?, _ result: inout [Int]) {
        guard let node = node else { return }
        result.append(node.index)
        preOrder(node.left, &result)
        preOrder(node.right, &result)
    }
    
    func postOrder() -> [Int] {
        var result = [Int]()
        postOrder(root, &result)
        return result
    }
    
    private func postOrder(_ node: Node?, _ result: inout [Int]) {
        guard let node = node else { return }
        postOrder(node.left, &result)
        postOrder(node.right, &result)
        result.append(node.index)
    }
}

class Node {
    var x: Int 
    var index: Int 
    var `left`: Node? 
    var `right`: Node?
    
    init(index: Int, x: Int) {
        self.index = index
        self.x = x
    }
}

func solution(_ nodeinfo:[[Int]]) -> [[Int]] {
    
    let tree = BST()
    
    nodeinfo.enumerated()
            .sorted { $0.element[1] > $1.element[1] }
            .forEach { offset, element in
        tree.insert(offset + 1, element[0])
    }
    
    return [tree.preOrder(), tree.postOrder()]
}