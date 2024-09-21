import Foundation
// 1123

// b_f: [x,y,a,b]
// return: 구조물의 상태


class Board {
    let count: Int
    var pmap: [[Bool]]
    var bmap: [[Bool]]
    
    init(_ n: Int) {
        self.count = n + 1
        self.pmap = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
        self.bmap = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
        
    }
    
    func isValidBo(_ x: Int, _ y: Int) -> Bool {
        guard x >= 0 && x < count && y >= 0 && y < count else { return true }
        guard bmap[x][y] else { return true }
        let existP = pmap[x][y - 1]
        let existP2 = pmap[x + 1][y - 1]
        let existBB = x - 1 >= 0 && x + 1 < count && bmap[x - 1][y] && bmap[x + 1][y]
        return existP || existP2 || existBB
    }
    
    func isValidPillar(_ x: Int, _ y: Int) -> Bool {
        guard x >= 0 && x < count && y >= 0 && y < count else { return true }
        guard pmap[x][y] else { return true }
        let isFloor = y == 0
        let existP = pmap[x][y - 1]
        let existB1 = x - 1 >= 0 && bmap[x - 1][y]
        let existB2 = bmap[x][y]
        return isFloor || existP || existB1 || existB2
    }
    
    var result: [[Int]] {
        var temp: [[Int]] = []
        
        for x in pmap.indices {
            for y in pmap[0].indices {
                if pmap[x][y] { temp.append([x,y,0])}
                if bmap[x][y] { temp.append([x,y,1])}
            }    
        }
        
        return temp.sorted(by: { $0[0] < $1[0] || ($0[0] == $1[0] && $0[1] < $1[1])})
        
    }
    
    func execute(_ cmd: [Int]) {
        let x = cmd[0]
        let y = cmd[1]
        let isPillar = cmd[2] == 0
        let isDelete = cmd[3] == 0
        
        if isPillar {
            isDelete ? deletePillar(x, y) : buildPillar(x, y)
        } else {
            isDelete ? deleteBo(x, y) : buildBo(x, y)
        }
    }
    
    private func buildBo(_ x: Int, _ y: Int) {
        guard pmap[x][y - 1] 
        || (x + 1 < count && pmap[x + 1][y - 1])
        || (x - 1 >= 0 && x + 1 < count && bmap[x - 1][y] && bmap[x + 1][y]) 
        else { return }
        bmap[x][y] = true
    }
    
    private func buildPillar(_ x: Int, _ y: Int) {
        guard y == 0 
        || bmap[x][y]
        || (x - 1 >= 0 && bmap[x - 1][y])
        || pmap[x][y - 1]
        else { return }
        pmap[x][y] = true
    }
    
    private func deleteBo(_ x: Int, _ y: Int) {
        bmap[x][y] = false
        let a = isValidBo(x - 1, y)
        let b = isValidBo(x + 1, y)
        let c = isValidPillar(x, y)
        let d = isValidPillar(x + 1, y)
        
        guard a && b && c && d else { 
            bmap[x][y] = true
            return 
        }
        
    }
    
    private func deletePillar(_ x: Int, _ y: Int) {
        pmap[x][y] = false
        let a = isValidBo(x - 1, y + 1)
        let b = isValidBo(x, y + 1)
        let c = isValidPillar(x, y + 1)
        guard a && b && c else { 
            pmap[x][y] = true
            return 
        }
    }
    

    
}


func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    
    var board = Board(n)
    
    build_frame.forEach {
        board.execute($0)
    }
    
    return board.result
}