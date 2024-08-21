import Foundation

// stones: 디딤돌 적힌 숫자
// k: 최개 칸수
// RETURN: 최대 몇명

// Idea 1: 그리디하게

// Idea 2: 이분탐색
// isPossible(n): n명 지나갔을 때 최대 거리가 k 이하인가?
// TTTTTFFFFFFFFFFf
func solution(_ stones:[Int], _ k:Int) -> Int {
    
    var low = 0
    var high = 200_000_001
    var mid: Int {
        (low + high) / 2
    }
    // 0 1 2 3 4
    // 0 1 0 0 1
    func isPossible(_ n: Int) -> Bool {
        
        var maxInterval = 0
        var lastIndex = -1
        
        for i in 0..<stones.count {
           if stones[i] - n > 0 { lastIndex = i }
            else  {
                maxInterval = max(maxInterval, i - lastIndex)
            }
        }

        return maxInterval < k
    }
    
    while low + 1 < high {
        if isPossible(mid) {
            low = mid
        } else {
            high = mid
        }
    }
    
    return low + 1
}