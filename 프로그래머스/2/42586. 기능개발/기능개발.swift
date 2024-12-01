import Foundation

// 23:53
// return: 각 배포마다 몇개 기능이 배포 되는 지
func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
    
    var progresses = Array(progresses.reversed())
    var speeds = Array(speeds.reversed())
    var result: [Int] = []
    
    while !progresses.isEmpty {
        var count = 1
        let progress = progresses.removeLast()
        let speed = speeds.removeLast()
        let leftProgress = 100 - progress
        let time = Int(ceil(Double(leftProgress) / Double(speed)))
        
        while !progresses.isEmpty {
            let progress = progresses.removeLast()
            let speed = speeds.removeLast()
            if time * speed + progress >= 100 {
                count += 1
            } else {
                progresses.append(progress)
                speeds.append(speed)
                break
            }
        }
        result.append(count)
    }
    return result
}