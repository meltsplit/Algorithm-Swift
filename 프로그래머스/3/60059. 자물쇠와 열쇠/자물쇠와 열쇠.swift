import Foundation


// 15:51

// key: 열쇠
// lock: 자물쇠
// return: 열 수 있는지 없는지

// 열쇠 회전, 이동 가능
// 열쇠 돌기 ~ 자물쇠 홈 = 열림
// 자물쇠 영역 내에서는 열쇠의 돌기 부분과 자물쇠 홈이 일치해야함.
// 돌기 돌기 만나면 안됨.
// 자물쇠 홈이 모두 채워져야 열림.

// Idea 1: 자물쇠 홈에 키의 돌기를 하나씩 넣으며 판단하기

// Idea 2: 열쇠 돌기에 자물쇠 홈을 하나씩 넣으며 판단하기

// Idea 3: 자물쇠 홈 모양이 열쇠에 있는지 돌려가며 

extension Array where Element == [Int] {
    func rotate() -> Self {
        let height = self.count
        let width = self[0].count
        
        var newValue = Array(repeating: Array<Int>(repeating: 0,count: height),count: width)
        for x in self.indices {
            for y in self[0].indices {
                newValue[y][height - 1 - x] = self[x][y]
            }
        }
        
        return newValue
    }
}

func check(_ map: [[Int]], _ key: [[Int]], _ originX: Int, _ originY: Int, _ n: Int) -> Bool {
    var map = map
    var lockList: [Int] = []
    // key 더하기
    for x in key.indices  {
        for y in key[0].indices {
            map[originX + x][originY + y] = map[originX + x][originY + y] + key[x][y]
        }
    }
    
    for x in 0..<n {
        for y in 0..<n {
            lockList.append(map[n + x][n + y])
        }
    }
    return lockList.allSatisfy { $0 == 1 }
}

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    let m = key.count
    let n = lock.count
    var map = Array(repeating: Array(repeating: 0, count: 3 * n), count: 3 * n)
    var keys = [key]
    for _ in 0..<3 { 
        keys.append(keys.last!.rotate()) 
    }
    
    // map 중앙에 자물쇠 위치 시키기
    for x in lock.indices {
        for y in lock[0].indices {
            map[x + n][y + n] = lock[x][y]
        }
    }
    
    for x in (n - m + 1)...(2 * n - 1) {
        for y in (n - m + 1)...(2 * n - 1) { 
            let isImpossible = keys.map { check(map, $0, x, y, n)}.allSatisfy { !$0 }
            guard isImpossible else { return true }
        }
    }
    
    return false
}