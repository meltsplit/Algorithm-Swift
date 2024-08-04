import Foundation

// 23 55
extension String {
    func toTimeInterval() -> Int {
        let time = self.split(separator: ":")
        let hours = Int(time[0])!
        let minutes = Int(time[1])!
        let totalTimes = hours * 60 + minutes
        return totalTimes
    }
}


func solution(_ book_time: [[String]]) -> Int {
    var book_time = book_time.map { ($0[0].toTimeInterval(), $0[1].toTimeInterval() + 10)}
                             .sorted { $0.0  < $1.0 }
    var endTimes = [Int]()
    var answer = 0
    
    for (startTime, endTime) in book_time {
        
        for i in endTimes.indices.reversed() {
            if endTimes[i] <= startTime { //이미 종료된 방이 있다면 지우기
                endTimes.remove(at: i)
            }
        }
            
        endTimes.append(endTime)
        answer = max(answer, endTimes.count)
    }
    
    return answer
}