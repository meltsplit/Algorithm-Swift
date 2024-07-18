import Foundation

// IDEA: 이분 탐색
// t 시간동안 심사관들이 n명의 사람을 처리할 수 있는가?
// 0 <= t <= 10 * n

// FFFFFFFFTTTTTTTTTTT
// 최솟값구하기

func solution(_ n:Int, _ times:[Int]) -> Int64 {
    
    var low = 0
    var high = n * times.max()!
    
    // time 시간동안 심사관들은 n명을 처리할 수 있는가?
    func isPossible(_ time: Int) -> Bool {
        var sum = 0
        for t in times {
            let done = time / t 
            sum += done
        }
        
        return sum >= n
    }
    
    while low + 1 < high {
        let mid = (low + high) / 2
        if isPossible(mid) {
            high = mid
        } else {
            low = mid
        }
    } 
   
    return Int64(high)
}
