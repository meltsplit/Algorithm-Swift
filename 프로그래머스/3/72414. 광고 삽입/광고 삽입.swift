import Foundation

// 13 15

// pt: 죠르디 재생 시간
// at: 공익 광고 재생 시간
// log: 시청자 재생했던 구간 정보
// return 공익광고 들어갈 시작 시간. 누적 재생 시간이 겹치면 가장 빠른 시각

// Idea 1: 그리디

// Idea 2: 이분탐색?

// 0~20: 3 
// 20~40: 3,2
// 40~45: 2
// 45~60: 
// 50~70: asdf

// Q. 답은 무조건 시작점에서만 도출되는가?

extension Int {
    var toTime: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 3600 % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension String {
    
    var toSeconds: Int { // 최대 359,999
        let time = self.split(separator: ":").map { Int($0)! }
        let hSeconds = time[0] * 3600
        let mSeconds = time[1] * 60
        let seconds = time[2]
        return hSeconds + mSeconds + seconds
    }
}

func solution(_ play_time:String, _ adv_time:String, _ logs:[String]) -> String {
    let totalSeconds = play_time.toSeconds // 최대 359,999
    let advSeconds = adv_time.toSeconds
    var table = Array(repeating: 0, count: totalSeconds + 1)  // 최대 count = 360,000
    var results: [Double] = []
    
    for log in logs {
        let times = log.split(separator: "-").map { String($0)}
        let start = times[0].toSeconds
        let end = times[1].toSeconds
        table[start] += 1
        table[end] -= 1
    }
    
    // 누적 합 계산
    for i in table.indices {
        guard i > 0 else { continue }
        table[i] += table[i - 1]
    }
    
    // 0초에 시작했을 때 계산
    
    var currentSum: Double = Double(table[0..<advSeconds].reduce(0, +))
    var maxSum = currentSum
    var maxSumTime: Int = 0

    for i in 1..<(table.count - advSeconds) {
        let sum: Double = currentSum - Double(table[i - 1]) + Double(table[i + advSeconds - 1]) 
        currentSum = sum
        if sum > maxSum {
            maxSumTime = i
            maxSum = sum
        }
    }
    
    return maxSumTime.toTime
}