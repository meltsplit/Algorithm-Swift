import Foundation

func solution(_ n:Int, _ times:[Int]) -> Int64 {
    let maxTime = times.max()!
    var start = 1
    var end = maxTime * n
    var mid = (start + end) / 2
    
    while start < end {
        mid = (start + end) / 2
        let count = times.reduce(0) { $0 + (mid / $1) }
        start = count < n ? mid + 1 : start
        end = count < n ? end : mid
    }
    
    return Int64(end)
}
