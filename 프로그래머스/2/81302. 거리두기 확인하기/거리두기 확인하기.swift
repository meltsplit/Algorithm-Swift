import Foundation

// 14 39

// places: 자리에 앉아있는 응시자들의 정보와 대기실 구조를 대기실별로 담은 2차원 문자열 배열
// - P는 응시자가 앉아있는 자리를 의미합니다.
// - O는 빈 테이블을 의미합니다.
// - X는 파티션을 의미합니다.

// solutuion: 지키면 1, 지키지 않으면 0


// Idea 1
// places를 Place 배열로 치환
// BFS로 탐색
// Place 에서 bfs

// BFS
// visited
// 다음 어디 방문할지 queue
// - 근방 인덱스 
//   - 상하좌우이지만 인덱스를 넘는 건 안돼.
// 

typealias Line = [Seat]
typealias Place = [Line]

enum Seat: Character {
    case p = "P"
    case o = "O"
    case x = "X"
}

extension Int {
    var isValidIndex: Bool {
        return self >= 0 && self < 5
    }
}

func dfs(_ place: Place, _ x: Int, _ y: Int, _ visited: inout [[Bool]], _ depth: Int, _ result: inout Bool) {

    guard depth < 3 else { return }
    guard place[x][y] != .x else { return } //가림막이기에 무조건 오케이
    
    if place[x][y] == .p && depth > 0 {
        result = false
    } 
    
    for (dx, dy) in zip([0,0,1,-1],[1,-1,0,0]) {        
        let nextX = x + dx
        let nextY = y + dy
        guard nextX.isValidIndex else { continue }
        guard nextY.isValidIndex else { continue }
        
        guard !visited[nextX][nextY] else { continue }
        visited[nextX][nextY] = true
        dfs(place, nextX, nextY, &visited, depth + 1, &result)
        visited[nextX][nextY] = false
    }
    
}

func solution(_ places:[[String]]) -> [Int] {
    
    var places: [Place] = places.map { $0.map { $0.map { Seat(rawValue: $0)! } } }    
    return places.map { place in 
        var result = true
        var visited = Array(repeating: Array(repeating: false, count: 5), count: 5)
        for x in 0..<5 {
            for y in 0..<5 {
                guard place[x][y] == .p else { continue }
                visited[x][y] = true
                dfs(place, x, y, &visited, 0, &result)
                visited[x][y] = false
            }
        }
        return result ? 1 : 0
        
    }
}