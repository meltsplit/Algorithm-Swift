import Foundation

// 1트: 1530 ~  17:30
// 2트: 1430

// x: 0..<n
// y: 0..<m
// return: 시작점의 개수

// Idea 1: dp: top down
// f(x,y) = [f(x - 1, y) +  ]

struct Point {
    var x: Int
    var y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

struct Points {
    let start: Point
    let end: Point
    
    var count : Int {
        let h = end.x - start.x + 1
        let w = end.y - start.y + 1
        return h * w
    }
}

struct QueryHandler {
    let n: Int
    let m: Int
    
    func validate(_ point: inout Point) {
        point.x = min(point.x, n - 1)
        point.x = max(point.x, 0)
        point.y = min(point.y , m - 1)
        point.y = max(point.y, 0)
    }
    
    func execute(_ prev: Points, _ query: [Int]) -> Points? {
        
        let cmd = query[0]
        let distance = query[1]
        
        var sdx = 0
        var sdy = 0
        
        var edx = 0
        var edy = 0
        
        switch cmd {
        case 0:  // <
            if prev.start.y != 0 { sdy = distance }
            edy = distance
            guard prev.start.y + distance < m else { return nil }
        case 1:  // >
            sdy = -1 * distance
            if prev.end.y != m - 1 { edy = -1 * distance }
            guard prev.end.y - distance >= 0 else { return nil }
        case 2: // ^
            if prev.start.x != 0 { sdx = distance }
            edx = distance
            guard prev.start.x + distance < n else { return nil }
        case 3: // v
            sdx = -1 * distance
            if prev.end.x != n - 1 { edx = -1 * distance }
            guard prev.end.x - distance >= 0 else { return nil }
        default: fatalError()
        }
        
        var nextStart = Point(prev.start.x + sdx, prev.start.y + sdy)
        var nextEnd = Point(prev.end.x + edx, prev.end.y + edy)
        
        validate(&nextStart)
        validate(&nextEnd)
        
        return Points(start: nextStart, end: nextEnd)
    }
}

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ queries:[[Int]]) -> Int64 {
    let target = Point(x, y)
    let queries = Array(queries.reversed())
    var dp = [Points]() 
    let handler = QueryHandler(n: n, m: m)
    
    
    for i in queries.indices  {
        let query = queries[i]
        let prev = i > 0 ? dp[i - 1] : Points(start: target, end: target)
        let _next = handler.execute(prev, query)
        guard let next = _next else { return 0}
        dp.append(next)
    }
    
    return Int64(dp.last!.count)
}