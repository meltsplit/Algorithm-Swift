import Foundation

// return 제재 아이디 목록 수

// 17:40 


// *rodo: frodo, crodo
// *rodo: frodo, crodo
// ******: abc123, frodoc

// frodo crodo abc123 frodoc

// (2 * 2 * 2) - (중복 경우) - (무의미한 경우)
// 중복 경우: ffa fff ccf cca
// 무의미한 경우: fca: cfa , fcf: cff -> Set

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    let userDict : [Int: [String]] = Dictionary(grouping: user_id, by: { $0.count })
    var banList : [[String]] = []
    var answers: Set<Set<String>> = []
    
    for ban in banned_id {
        let users = userDict[ban.count] ?? []
        let wilBan = users.filter { zip($0,ban).allSatisfy {$1 == "*" || $0 == $1 }}
        banList.append(wilBan)
    }
    
    
    func dfs(_ depth: Int, _ visited: Set<String>) {
        var visited = visited
        
        guard depth < banList.count else { 
            answers.insert(visited)
            return 
        }
   
        
        for user in banList[depth] {
            guard !visited.contains(user) else { continue }
            dfs(depth + 1, visited.union([user]))
        }
        
    }
    
    dfs(0, [])
    
    return answers.count
}