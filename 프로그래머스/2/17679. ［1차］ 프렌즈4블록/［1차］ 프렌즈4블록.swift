// Idea 1: BFS
// 자료구조: 배열을 세로로 설정
// 1. 4개짜리를 찾는다.
// 2. 찾은 인덱스 값을 지운다.
// 3. 배열의 길이를 length에 맞게 빈 문자열 ""을 채운다
// 4. 1~3을 반복한다.
// 5. 4개짜리가 없으면 중단.

// board
//1...n
//..
//m..

// newBoard
//1...m
//..
//n..

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
    
    func check(_ x: Int, _ y: Int) -> Set<Point> {
        var answer = Set<Point>()
        
        let point = Point(x: x, y: y)
        
        let me = newBoard[x][y]
        
        let ul = getData(point.ul)
        let u = getData(point.u)
        let ur = getData(point.ur)
        let l = getData(point.l)
        let r = getData(point.r)
        let dl = getData(point.dl)
        let d = getData(point.d)
        let dr = getData(point.dr)
        
        if let ul = ul,
           let u = u,
           let l = l {
               if Set([me,ul,u,l]).count == 1 {
                   answer.insert(point)
                   answer.insert(point.ul)
                   answer.insert(point.u)
                   answer.insert(point.l)
               }
           }
        
        if let ur = ur,
           let u = u,
           let r = r {
               if Set([me,ur,u,r]).count == 1 {
                   answer.insert(point)
                   answer.insert(point.ur)
                   answer.insert(point.u)
                   answer.insert(point.r)
               }
           }
        
        if let dl = dl,
           let d = d,
           let l = l {
               if Set([me,dl,d,l]).count == 1 {
                   answer.insert(point)
                   answer.insert(point.dl)
                   answer.insert(point.d)
                   answer.insert(point.l)
               }
           }
        
        if let dr = dr,
           let d = d,
           let r = r {
               if Set([me,dr,d,r]).count == 1 {
                   answer.insert(point)
                   answer.insert(point.dr)
                   answer.insert(point.d)
                   answer.insert(point.r)
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