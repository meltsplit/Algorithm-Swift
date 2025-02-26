import Foundation

// 1413
// return: 기지국 최솟값
func solution(_ n:Int, _ stations:[Int], _ w:Int) -> Int{
    var answer = 0 
    var low = 1

    for station in stations {
        let high = station - (w + 1)
        let distance = high - low + 1
        low = station + w + 1
        guard distance > 0 else { continue }
        answer += Int(ceil(Double(distance) / Double(2 * w + 1)))
    }
    
    let high = n
    let distance = high - low + 1
    if distance > 0 {
        answer += Int(ceil(Double(distance) / Double(2 * w + 1)))
    }

    return answer
}