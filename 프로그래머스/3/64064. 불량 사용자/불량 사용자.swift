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
    var dict : [Int: [String]] = [:]
    var bannedUser : [[String]] = []
    var answer: Set<Set<String>> = []
    
    for user in user_id {
        dict[user.count, default: []].append(user)
    }
    
    for ban in banned_id {
        let users = dict[ban.count] ?? []
        let user = users.filter { zip($0,ban).allSatisfy {$1 == "*" || $0 == $1 }}
        bannedUser.append(user)
    }
    
    
    func dfs(_ depth: Int, _ visited: Set<String>) {
        var visited = visited
        
        guard depth < bannedUser.count else { 
            answer.insert(visited)
            return 
        }
   
        
        for user in bannedUser[depth] {
            guard !visited.contains(user) else { continue }
            visited.insert(user)
            dfs(depth + 1, visited)
            visited.remove(user)
        }
        
    }
    
    dfs(0, [])
    
    return answer.count
}