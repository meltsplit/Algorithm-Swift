import Foundation

// 1236
// return: 숫자의 합의 최댓값

func solution(_ sticker:[Int]) -> Int{
    guard sticker.count > 2 else { return sticker.first! }
    
    var dp1 = Array(repeating: (0, false), count: sticker.count)
    var dp2 = Array(repeating: (0, false), count: sticker.count)
    
    dp1[0] = (sticker.first!, true)
    dp2[0] = (0, false)
    
    dp1[1] = (sticker.first!, false)
    dp2[1] = (sticker[1], true)
    
    func execute(_ dp: [(Int, Bool)], _ newValue: Int, _ i: Int) -> (Int, Bool) {
        if !dp[i - 1].1 { 
            return (dp[i - 1].0 + newValue, true)
        } else {
            let a = dp[i - 2].0 + newValue
            let b = dp[i - 1].0
            if a > b {
                return (a, true)
            } else {
                return (b, false)
            }
        }
    }
    
    for i in sticker.indices where i > 1 {
        let newValue = sticker[i]
        if i < sticker.count - 1 {
            dp1[i] = execute(dp1, newValue, i)
        } else {
            dp1[i] = dp1[i - 1]
        }
        dp2[i] = execute(dp2, newValue, i)
    }

    return max(dp1.last!.0, dp2.last!.0)
}