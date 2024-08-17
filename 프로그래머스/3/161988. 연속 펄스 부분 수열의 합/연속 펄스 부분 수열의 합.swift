func solution(_ sequence:[Int]) -> Int64 {
    
    // -1로 시작하는 배열
    var dp1 = Array(repeating: 0, count: sequence.count)
    
    // 1로 시작하는 배열
    var dp2 = Array(repeating: 0, count: sequence.count)
    
    var dpnum1 = [-1]
    var dpnum2 = [1]
    
    var num = 1
    
    for i in 1..<sequence.count {
        dpnum1.append(num)
        dpnum2.append(-num)
        num = -num
    }
    
    dp1[0] = dpnum1[0] * sequence[0]
    dp2[0] = dpnum2[0] * sequence[0]
    
    for i in 1..<sequence.count {
        dp1[i] = max(sequence[i]*dpnum1[i], dp1[i-1]+(sequence[i]*dpnum1[i]))
        dp2[i] = max(sequence[i]*dpnum2[i], dp2[i-1]+(sequence[i]*dpnum2[i]))
    }
    
    return Int64(max(dp1.max()!, dp2.max()!))
}