import Foundation

// return: 네트워크 개수
 
func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var parents = (0..<n).map { $0 }

    func find(_ x: Int) -> Int {
        if parents[x] == x { return x }
        parents[x] = find(parents[x])
        return parents[x]
    }

    func union(_ x: Int, _ y: Int) {
        parents[find(x)] = find(y)
    }
    
    for i in 0..<n {
        for j in (i + 1)..<n {
            guard computers[i][j] == 1 else { continue }
            union(i,j)
        }
    }
    
    parents.indices.forEach { find($0) }
    
    return Set(parents).count
}