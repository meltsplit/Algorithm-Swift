
struct Point: Hashable {
    var x: Int
    var y: Int
    
    var ul: Point {
        return Point(x: x - 1, y: y - 1)
    }

    var u: Point {
        return Point(x: x, y: y - 1)
    }
    
    var ur: Point {
        return Point(x: x + 1, y: y - 1)
    }
    
    var l: Point {
        return Point(x: x - 1, y: y)
    }
    
    var r: Point {
        return Point(x: x + 1, y: y)
    }
    
    var dl: Point {
        return Point(x: x - 1, y: y + 1)
    }
    
    var d: Point {
        return Point(x: x, y: y + 1)
    }
    
    var dr: Point {
        return Point(x: x + 1, y: y + 1)
    }
    
}

func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    var board = board.map { $0.map { String($0) }}
    var newBoard: [[String?]] = Array(repeating: Array(repeating: nil, count: m), count: n)
    for y in 0..<m {
        for x in 0..<n {
            newBoard[x][m - 1 - y] = board[y][x]
        }
    }
    
    
    func getData(_ point: Point) -> String? {
        guard point.x >= 0 && point.x < n else { return nil }
        guard point.y >= 0 && point.y < m else { return nil }
        return newBoard[point.x][point.y]
    }
    
    func checkSquare(_ points: [Point]) -> Bool{
        var values = points.compactMap(getData)
        guard points.count == values.count else { return false }
        return Set(values).count == 1
    }
    
    func check(_ x: Int, _ y: Int) -> Set<Point> {
        var answer = Set<Point>()
        
        let point = Point(x: x, y: y)
        
        [[point, point.ul, point.u, point.l],
         [point, point.ur, point.u, point.r],
         [point, point.dl, point.d, point.l],
         [point, point.dr, point.d, point.r]
        ].forEach {
            if checkSquare($0) {
                answer = answer.union($0)
            }
        }
  
        return answer
    }
    
    var answer = 0
    while true {
    var ableToRemove = Set<Point>()
    
    for x in 0..<n {
        for y in 0..<m {
            ableToRemove = ableToRemove.union(check(x,y))
        }
    }
        
    guard ableToRemove.count >= 4 else { break }
        
    let needToRemove = ableToRemove.sorted { $0.y > $1.y}
        
    for point in needToRemove {
        answer += 1
        newBoard[point.x].remove(at: point.y)
    }
    
    for i in newBoard.indices {
        for _ in 0..<(m - newBoard[i].count) {
            newBoard[i].append(nil)
        }
    }
    }
    
    
    return answer
}