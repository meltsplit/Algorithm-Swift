import Foundation

// 16:43
// return 승리할 확률 높아지는 주사위

func combination(_ elements: [Int], _ k: Int) -> [[Int]] {
    var result = [[Int]]()
    
    func combi(_ now: [Int], _ index : Int) {
        if now.count == k {
            result.append(now)
            return
        }
        
        for i in index..<elements.count {
            combi(now + [elements[i]], i + 1)
        }
        
    }
    
    combi([], 0)
    return result
    
}

func solution(_ dice:[[Int]]) -> [Int] {
    var answer = [Int]()
    var maxWin = Int.min
    var cache: [[Int]: [Int]] = [:]
    
    var aDices = Set(combination(Array(0..<dice.count), dice.count / 2))
    
    func dfs(_ i: Int, _ diceIndex: [Int], _ now: Int, _ result: inout [Int]) {
        guard i < diceIndex.count else { 
            result.append(now)
            return 
        }
        
        for j in dice[diceIndex[i]] {
            dfs(i + 1, diceIndex, now + j, &result)
        }
    }
    
    
    for aDiceSet in aDices {
        let aDice = Array(aDiceSet).sorted()
        let bDice = (0..<dice.count).filter { !aDice.contains($0) }
        
        var aResults = [Int]()
        var bResults = [Int]()
        
        if let result = cache[aDice] {
            aResults = result
        } else {
            dfs(0, aDice, 0, &aResults)
            aResults.sort()
            cache[aDice] = aResults
        }
        
        if let result = cache[bDice] {
            bResults = result
        } else {
            dfs(0, bDice, 0, &bResults)
            bResults.sort()
            cache[bDice] = bResults
        }
        
        var p = 0
        var aWins = 0
        
        for i in aResults.indices {
            let a = aResults[i]
            while p < bResults.count {
                guard bResults[p] < a else {
                    aWins += p
                    break
                }
                p += 1
            }
            
            if p == bResults.count {
                let count = aResults.count - i
                aWins += p * count
                break
            }
        }
        
        if aWins >= maxWin {
            maxWin = aWins
            answer = aDice
        }
    }
    
    
    return answer.map { $0 + 1}
}