import Foundation
// 12 43

// dp: 작은문제들이 큰 문제의 부분집합일 때

// f1(x) = x개를 떼었을 때의 최댓값
// f2(x) = x번째 인덱스까지의 최댓값

// f1(x) = f(x-1) + newValue

// f2(x) = max(f2(x-1), f2(x-2) + sticker[x]) // 나를 포함시키지 않거나, 포함 시키거나.
// 

// n이 홀수일 때 
// 1, 1, 2, 5, 4

func solution(_ sticker:[Int]) -> Int{
    
    var dp1 : [Int] = [] 
    var dp2 : [Int] = [] 
    
    for i in sticker.indices {
        guard i != 0 else { 
            dp1.append(sticker[i]) 
            dp2.append(0)
            continue
        } 
    
        guard i != 1 else { 
            dp1.append(max(sticker[0], sticker[1]))
            dp2.append(sticker[1])
            continue
        }
        
        
        
        if i < sticker.count - 1 {
            dp1.append(max(dp1[i-1], dp1[i-2] + sticker[i]))    
        } 
        dp2.append(max(dp2[i-1], dp2[i-2] + sticker[i]))    
        
        
    }
    
    
    
    return max(dp1.last!,dp2.last!)
    
}