import Foundation

// 00 28
// sol: 건설 최소 비용

// Idea 1: 각 인덱스까지 가는 최소 비용

enum Direction: Int, CaseIterable {
    case up, down, left, right
    
    var dx: Int {
        switch self {
            case .up: return -1
            case .down: return 1
            case .left: return 0
            case .right: return 0
        }
    }
    
    var dy: Int {
        switch self {
            case .up: return 0
            case .down: return 0
            case .left: return -1
            case .right: return 1
        }
    }
}

func solution(_ board:[[Int]]) -> Int {
    
    var costBoard = Array(repeating: Array(repeating: Int.max, count: board.count), count: board.count)
    var dirBoard = Array(repeating: costBoard, count: 4)
    
    for i in 0..<4 {
        dirBoard[i][0][0] = 0
    }
    
    func isValid(_ x: Int, _ y: Int) -> Bool {
        return x >= 0 && x < board.count && y >= 0 && y < board.count 
    }
    
    func dfs(_ x: Int, _ y: Int, _ prevDir: Direction) {
       
        let dx = [-1, 1, 0, 0]
        let dy = [0, 0, -1, 1]
        
        for i in 0..<4 {
            let nextX = x + dx[i]
            let nextY = y + dy[i]
            let nextDir = Direction(rawValue: i)!
            let nextCost = dirBoard[prevDir.rawValue][x][y] + (prevDir == nextDir ? 100 : 600)
             
            guard isValid(nextX, nextY) else { continue }
            guard nextCost < dirBoard[i][nextX][nextY] else { continue }
        
            dirBoard[i][nextX][nextY] = nextCost
            guard board[nextX][nextY] == 0 else { continue }
            dfs(nextX, nextY, nextDir)
        }
    }
    
    for dir in Direction.allCases {
        dfs(0,0, dir)
    }
    
    return dirBoard.map { $0[board.count-1][board.count-1] }.min()! 
}