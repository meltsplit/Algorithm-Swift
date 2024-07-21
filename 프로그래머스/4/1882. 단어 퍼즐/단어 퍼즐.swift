import Foundation

func solution(_ strs: [String], _ t: String) -> Int {
    let strsSet = Set(strs) // 중복 제거
    let n = t.count
    var dp = Array(repeating: Int.max / 2, count: n + 1)
    dp[0] = 0 // dp의 첫번째 값은 아무 의미 없기 때문에 0으로 처리

    let tArray = Array(t)
    
    for i in 0..<n {
        let s = i
            
        for j in 1...5 {
            let e = s + j
            if e > n {
                break
            }
        
            let substring = String(tArray[s..<e])
            if strsSet.contains(substring) {
                dp[e] = min(dp[s] + 1, dp[e])
            }
        }
    }
    
    return dp[n] == Int.max / 2 ? -1 : dp[n]
}