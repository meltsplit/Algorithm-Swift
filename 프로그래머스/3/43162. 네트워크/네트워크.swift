import Foundation

// Idea 1: 유니온 파인드로 서로 다른 부모 몇개인지 구별하기
// 부모 배열 만들고
// 포문 돌아가며 find및 유니온 수행
// 부모 배열에 서로다른 원소 몇개있는 지 coun

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var parents = (0..<n).map { $0 }
    
    func find(_ a: Int) -> Int {
        guard a != parents[a] else { return a }
        parents[a] = find(parents[a])
        return parents[a]
    }
    
    func union(_ a: Int, _ b: Int) {
        let parentOfA = find(a)
        let parentOfB = find(b)
        
        guard parentOfA == parentOfA else { return } 
        
        if parentOfA < parentOfB {
            parents[parentOfB] = parentOfA
        } else {
            parents[parentOfA] = parentOfB
        }
    }
    
    for i in 0..<n {
        for j in 0..<n {
            if computers[i][j] == 1 {
                union(i,j)
            }
        }
    }
    
    for i in parents.indices {
        parents[i] = find(i)
    }
    

    return Set(parents).count
}