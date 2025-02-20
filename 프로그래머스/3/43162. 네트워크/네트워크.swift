import Foundation


// return: 네트워크 개수

// Idea 1: dfs
// 방문 처리 하면서, 노드가 끝났을 때 answer + 1
// O(n ^ 2)
func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var parent = (0..<n).map { $0 }
    
    func find(_ a: Int) -> Int {
        guard parent[a] != a else { return a }
        parent[a] = find(parent[a])
        return parent[a]
    }
    
    func union(_ a: Int, _ b: Int) {
        let parentA = find(a)
        let parentB = find(b)
        
        if parentA <= parentB { // b가 a의 부모를 따라가야 함
            parent[parentB] = parentA
        } else {
            parent[parentA] = parentB
        }
    }
    
    for i in 0..<n {
        for j in (i + 1)..<n {
            guard computers[i][j] == 1 else { continue }
            print(i,j,"병합")
            union(i,j)
            print(parent)
        }
    }
    
    for i in 0..<n {
        find(i)
    }
    
    return Set(parent).count
}