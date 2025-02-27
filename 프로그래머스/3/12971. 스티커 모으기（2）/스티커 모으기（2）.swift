import Foundation

// 1236
// return: 숫자의 합의 최댓값

func solution(_ sticker:[Int]) -> Int{
    guard sticker.count > 2 else { return sticker.first! }
    
    var dp1 = [Int]()
    var dp2 = [Int]()
    
    dp1.append(sticker.first!)
    dp1.append(sticker.first!)
    
    dp2.append(0)
    dp2.append(sticker[1])
 
    
    for i in sticker.indices where i > 1 {
        let newValue = sticker[i]
        if i < sticker.count - 1 {
            dp1.append(max(dp1[i - 2] + newValue, dp1[i - 1]))
        } 
        dp2.append(max(dp2[i - 2] + newValue, dp2[i - 1]))
    }

    return max(dp1.last!, dp2.last!)
}