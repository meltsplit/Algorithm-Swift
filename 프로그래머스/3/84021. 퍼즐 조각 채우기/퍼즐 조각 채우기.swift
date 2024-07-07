struct Coord: Hashable {
  
    let x: Int
    let y: Int
    
    func getAdjacencyCoord() -> [Coord] {
        let dx = [0,0,1,-1]
        let dy = [1,-1,0,0]
        
        return zip(dx,dy).map { 
            Coord(
            x: self.x + $0.0,
            y: self.y + $0.1)
        }
    }
    
    func isValid(_ maxX: Int, _ maxY: Int) -> Bool {
        return x >= 0 && x <= maxX && y >= 0 && y <= maxY
    }
}

extension Set where Element == Coord {
    
    func normalize() -> Set<Coord> {
        guard !self.isEmpty else { return Set() }
        let minX = self.min(by: { $0.x < $1.x})!.x
        let minY = self.min(by: { $0.y < $1.y})!.y
        return Set(self.map { Coord(x: $0.x - minX, y: $0.y - minY)})
    }
    
    func rotate() -> Set<Coord> {
        guard !self.isEmpty else { return Set() }
        let minX = self.min(by: { $0.x < $1.x})!.x
        let maxX = self.max(by: { $0.x < $1.x})!.x
        let width = maxX - minX
        return Set(self.map { Coord(x: $0.y, y: width - $0.x)})
    }
}

struct Shape: Equatable {
    
    private let coord: Set<Coord>
    
    private var ableCoord: Set<Set<Coord>> {
           var sets = Set<Set<Coord>>()
           var current = coord
           for _ in 0..<4 {
               current = current.rotate().normalize()
               sets.insert(current)
           }
           return sets
       }
    
    var count: Int {
        return coord.count
    }
    
    init(coord: Set<Coord>) {
        self.coord = coord.normalize()
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.ableCoord.contains(rhs.coord)
    }
}

func solution(_ game_board:[[Int]], _ table:[[Int]]) -> Int {
    var gameShapes = [Shape]()
    var tableShapes = [Shape]()
    var game_board_visisted = Array(repeating:
                            Array(repeating: false,
                                  count: game_board[0].count),
                         count: game_board.count)
    
    var table_visisted = Array(repeating:
                            Array(repeating: false,
                                  count: table[0].count),
                         count: table.count)
    
    func bfs(
        _ x: Int, 
        _ y: Int, 
        _ map: [[Int]], 
        _ visited: inout [[Bool]],
        _ target: Int
    ) {
        var result: Set<Coord> = []
        var queue: [Coord] = []
        
        queue.append(Coord(x: x, y: y))
        visited[x][y] = true
        
        while !queue.isEmpty {
            let now = queue.removeFirst()
            result.insert(now)
            
            for next in now.getAdjacencyCoord() {
                guard next.isValid(map.count - 1, map[0].count - 1) 
                else { continue }
                guard !visited[next.x][next.y] && map[next.x][next.y] == target 
                else { continue }
                
                visited[next.x][next.y] = true
                queue.append(next)
            }
        }
        
        if target == 0 {
            gameShapes.append(Shape(coord: result))
        } else {
            tableShapes.append(Shape(coord: result))
        }
        
    }
    
    // 게임 보드 블럭 찾기
    for x in game_board.indices {
        for y in game_board[0].indices {
            if !game_board_visisted[x][y] && game_board[x][y] == 0 {
                bfs(x, y, game_board, &game_board_visisted, 0)
            }
        }
    }
    
    // 테이블 블럭 찾기
    for x in table.indices {
        for y in table[0].indices {
            if !table_visisted[x][y] && table[x][y] == 1 {
                bfs(x, y, table, &table_visisted, 1)
            }
        }
    }
    
    
    var answer = 0
    
    for tableShape in tableShapes {
        if let index = gameShapes.firstIndex(of: tableShape) {
            answer += tableShape.count
            gameShapes.remove(at: index)
        }
    }
    
    return answer
}