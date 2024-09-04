import Foundation
// 12:18

// board: 건물 내구도
// skill: 적 공격, 아군 회복 스킬
// Return: 파괴되지 않은 건물 개수

// skill은 항상 직사각형

// Idea : 구현
// 시간초과: 

struct Skill {
    let isEnemy: Bool
    let startIndex: (x: Int, y: Int)
    let endIndex: (x: Int, y: Int)
    
    private let _degree: Int
    var degree: Int { isEnemy ? -1 * _degree : _degree }
    
    init(_ skill: [Int]) {
        isEnemy = skill[0] == 1
        startIndex = (skill[1], skill[2])
        endIndex = (skill[3], skill[4])
        _degree = skill[5] 
    }
}

extension Array where Element == [Int] {
    
    mutating func mark(_ skill: Skill) {
        self[skill.startIndex.x][skill.startIndex.y] += skill.degree
        self[skill.startIndex.x][skill.endIndex.y + 1] -= skill.degree
        self[skill.endIndex.x + 1][skill.startIndex.y] -= skill.degree
        self[skill.endIndex.x + 1][skill.endIndex.y + 1] += skill.degree
    }
    
    mutating func sumDegree(_ degrees: [[Int]]) {
        for r in self.indices {
            for c in self[0].indices {
                self[r][c] += degrees[r][c]
            }
        }
    }
    
    var safeCount: Int {
        var result = 0
        for r in self.indices {
            for c in self[0].indices {
                if self[r][c] > 0 {
                    result += 1
                }
            }
        }
        return result
    }
}


func solution(_ board:[[Int]], _ skill:[[Int]]) -> Int {
    var board = board
    var degrees = Array(repeating: Array(repeating: 0, count: board[0].count + 1), count: board.count + 1)
    
    skill.forEach { degrees.mark(Skill($0)) }
    
    for r in degrees.indices {
        var sum = 0
        for c in degrees[0].indices {
            sum += degrees[r][c]
            degrees[r][c] = sum
        }
    }
    
    for c in degrees[0].indices {
        var sum = 0
        for r in degrees.indices {
            sum += degrees[r][c]
            degrees[r][c] = sum
        }
    }
    
    board.sumDegree(degrees)
    
    return board.flatMap { $0 }.filter { $0 > 0 }.count
}