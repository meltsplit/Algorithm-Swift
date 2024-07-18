import Foundation

// 500kg
// 2kg
// 249번 왕복 = 498 편도
// 1번 편도
// 499 편도

// w/t = 효율, 높을수록 좋음.

// IDEA 1
// 도시별로 효율을 구해
// 0번 도시 효율: 1초에 25
// 1번 도시 효율: 1초에 12.5
// 2번 도시 효율: 1초에 2

// 반례 1
// 효율이 좋은 것이 두번 일하는 것보다
// 동시에 일하는 것이 더 시간 단축될 수 있음
// 동시에 일하는 것을 어떻게 수행할 것인가.
// 동시에 시키면 됨. 조건을 채운 break 하고.

// 반례 2
// 금과은 중에 어떤 것을 운반해야 더 효율적일까? 를 계산할 수 있나


// 자료구조 1
// Queue?
// 



func solution(_ a:Int, _ b:Int, _ g:[Int], _ s:[Int], _ w:[Int], _ t:[Int]) -> Int64 {
    
    var low = 0
    var high = 400000000000000
    
    func isPossible(_ mid: Int) -> Bool {
        var totalGold = 0
        var totalSilver = 0
        var totalWeight = 0
        
        for i in g.indices {
            let gold = g[i]
            let silver = s[i]
            let weight = w[i]
            let time = t[i]
            
            var count = mid / (time * 2) 
            if mid % (time * 2) >= time {
                count += 1
            }
            
            let weightsCanBeMoved = min(count * weight, gold + silver)
            
            totalWeight += weightsCanBeMoved
            totalGold += min(gold, weightsCanBeMoved) 
            totalSilver += min(silver, weightsCanBeMoved) 
        }
        
        return totalWeight >= (a + b)
        && totalGold >= a
        && totalSilver >= b
    }
    
    while low + 1 < high {
        let mid = (low + high) / 2
        let isEnabled = isPossible(mid)
        if isEnabled {
            high = mid
        } else {
            low = mid
        }
    }
    
    return Int64(high)
}