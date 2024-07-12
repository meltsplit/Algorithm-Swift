import Foundation

struct Point: Hashable {
    let y: Int
    let x: Int
}

struct Route: Hashable {
    let from: Point
    let to: Point
}

func solution(_ arrows:[Int]) -> Int {
    var answer = 0
    // y, x 이동 좌표
    let move = [(-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)]
    var isVisited: [Point : Bool] = [:]
    var isVisitedDirection: [Route: Bool] = [:]
    
    var now = Point(y: 0, x: 0)
    isVisited[now] = true
    arrows.forEach { arrow in
        for _ in 0..<2 {
            let next = Point(y: now.y + move[arrow].0, x: now.x + move[arrow].1)
            if isVisited[next] == true {
                if isVisitedDirection[Route(from: now, to: next)] == nil {
                    answer += 1
                }
            } else {
                isVisited[next] = true
            }
            isVisitedDirection[Route(from: now, to: next)] = true
            isVisitedDirection[Route(from: next, to: now)] = true
            now = next
        }
    }
    return answer
}