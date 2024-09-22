import Foundation
// 15:00

// return : 미로 탈출 경로 or 임파서벌
// d l r u 순서

func solution(_ n:Int, _ m:Int, _ x:Int, _ y:Int, _ r:Int, _ c:Int, _ k:Int) -> String {
    let x = x - 1
    let y = y - 1
    let r = r - 1
    let c = c - 1
    
    func dfs(_ x: Int, _ y: Int, _ depth: Int, _ path: [String]) -> [String]? {
        guard x >= 0 && x < n && y >= 0 && y < m else { return nil } // 범위 벗어나면 아웃
        let l1Distance = abs(r - x) + abs(c - y) 
        let ableDistance = k - depth
        guard ableDistance >= l1Distance else { return nil } // k가 충분해야함
        guard l1Distance % 2 == ableDistance % 2 else { return nil } // 짝홀이 맞아야함
        
        if depth == k {
            if x == r && y == c { return path }
            else { return nil }
        }
        
        if let path = dfs(x + 1, y, depth + 1, path + ["d"]) { return path }
        if let path = dfs(x ,y - 1, depth + 1, path + ["l"]) { return path }
        if let path = dfs(x,y + 1, depth + 1, path + ["r"]) { return path }
        if let path = dfs(x - 1,y, depth + 1, path + ["u"]) { return path }
        return nil
    }
    
    return dfs(x,y,0, [])?.joined() ?? "impossible"
}