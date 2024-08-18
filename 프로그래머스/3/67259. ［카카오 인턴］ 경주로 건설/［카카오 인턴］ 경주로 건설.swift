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
        return x >= 0 && x < board.count && y >= 0 && y < board.count && board[x][y] == 0
    }
    
    func dfs(_ x: Int, _ y: Int, _ cost: Int, _ prevDir: Direction) {
        
        guard isValid(x,y) else { return }
        guard cost < dirBoard[prevDir.rawValue][x][y] || (x == 0 && y == 0)  else { return }
        
        dirBoard[prevDir.rawValue][x][y] = cost
        
        for dir in Direction.allCases {
            let nextCost = prevDir == dir ? 100 : 600
            dfs(x + dir.dx, y + dir.dy, cost + nextCost, dir)
        }
    }
    
    for dir in Direction.allCases {
        dfs(0,0,0, dir)
    }
    
    return dirBoard.map { $0[board.count-1][board.count-1] }.min()! 
}