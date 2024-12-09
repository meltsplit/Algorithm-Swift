import Foundation 
extension Array where Element == Int {
    func toProblem() -> Problem {
        return .init(
            alp_req: self[0],
            cop_req: self[1],
            alp_rwd: self[2],
            cop_rwd: self[3],
            cost: self[4]
        )
    }
}

struct Problem {
    let alp_req: Int
    let cop_req: Int
    let alp_rwd: Int
    let cop_rwd: Int
    let cost: Int
}


func solve(
    alp: Int, cop: Int, alpMax: Int, copMax: Int, problems: [Problem], dp: inout [[Int]]
) {
    for problem in problems {
        guard alp >= problem.alp_req else { continue }
        guard cop >= problem.cop_req else { continue }
        
        let nextAlp = min(alp + problem.alp_rwd, alpMax)
        let nextCop = min(cop + problem.cop_rwd, copMax)
        
        dp[nextAlp][nextCop] = min(dp[nextAlp][nextCop], dp[alp][cop] + problem.cost)
    }
}

func solution(
    _ alp: Int,
    _ cop: Int,
    _ problems: [[Int]]
) -> Int {
    var problems = problems.map { $0.toProblem() }
    problems.append(.init(alp_req: 0, cop_req: 0, alp_rwd: 1, cop_rwd: 0, cost: 1))
    problems.append(.init(alp_req: 0, cop_req: 0, alp_rwd: 0, cop_rwd: 1, cost: 1))
    var alp_max = alp
    var cop_max = cop
    
    let aMax = problems.max { $0.alp_req < $1.alp_req }!.alp_req
    let cMax = problems.max { $0.cop_req < $1.cop_req }!.cop_req
    
    alp_max = max(alp, aMax)
    cop_max = max(cop, cMax)
    
    var dp = Array(
        repeating: Array(repeating: Int.max, count: cop_max + 1),
        count: alp_max + 1
    )
    dp[alp][cop] = 0
    
    for a in alp...alp_max {
        for c in cop...cop_max {
            solve(alp: a, cop: c, alpMax: alp_max, copMax: cop_max, problems: problems, dp: &dp)
        }
    }
    

    return dp[alp_max][cop_max]
}
