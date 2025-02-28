import Foundation

// 1700

// return: 제외할 경우의 수


func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    var visited = Set<String>()
    var answers = Set<Set<String>>()
    
    func dfs(_ depth: Int, _ bag: Set<String>) {
        guard depth < banned_id.count 
        else { 
            answers.insert(bag)
            return 
        }
        
        let target = banned_id[depth]
        let nexts = user_id.compactMap { user -> String? in
            guard !visited.contains(user) else { return nil }
            guard target.count == user.count else { return nil }
            
            guard target.enumerated().allSatisfy({ i, c in
                let index = user.index(user.startIndex, offsetBy: i)
                return c == "*" || c == user[index]
            }) else { return nil }
            return user
        }
        
        
        for next in nexts {
            visited.insert(next)
            var bag = bag
            bag.insert(next)
            dfs(depth + 1, bag)
            visited.remove(next)
        }
    }
    dfs(0, [])
    return answers.count
}