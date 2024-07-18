import Foundation

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