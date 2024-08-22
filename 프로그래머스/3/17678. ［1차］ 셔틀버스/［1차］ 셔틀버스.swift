// 14: 24

// 09:00부터 n회, t분 간격, m명,
// Return: 콘의 도착시각 중 제일 늦은 시각

// Idea 1: 
// 각 시간마다 우선 순위 큐 확인
// 우선 순위 큐: 
// 만약 해당 시간대 버스가 마지막이라면 (n번째 버스일 때)
// 콘의 시간을 우선순위큐에 포함되도록 설정

extension Int {
    var toTime: String {
        let hours = self / 60
        let minutes = self % 60 
        return String(format: "%02d", hours) + ":" + String(format: "%02d", minutes)
    }
}

struct Time: Comparable {
    let rawValue: String
 
    var hours: Int {
        return Int(rawValue.split(separator: ":")[0])!
    }
    var minutes: Int {
        return Int(rawValue.split(separator: ":")[1])!
    }
    
    var totalMinutes: Int {
        hours * 60 + minutes
    }
    
    init(_ rawValue: String) {
        self.rawValue = rawValue
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.totalMinutes < rhs.totalMinutes
    }
}

func solution(_ n:Int, _ t:Int, _ m:Int, _ timetable:[String]) -> String {
    var n = n
    var currentTime = 9 * 60
    var queue = [Time]()
    var timeTable = timetable.map { Time($0) }.sorted { $0 > $1}
    var answer = 0
          
    while n > 0 {
        let index = timeTable.firstIndex { $0.totalMinutes <= currentTime } ?? timeTable.count
        let waitCount = timeTable.count - index
        let pickUpCount = min(waitCount, m)
        var crew = [Int]()
        for _ in 0..<pickUpCount {
            crew.append(timeTable.removeLast().totalMinutes)
        }
 
        n -= 1 
        
        if n == 0 {
            guard !crew.isEmpty else { return currentTime.toTime }
            guard crew.count == m else { return currentTime.toTime }
            return (crew.last! - 1).toTime
        }
        
        currentTime += t
    }
    
    return ""
}