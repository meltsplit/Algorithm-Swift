import Foundation

// 0200

// 
extension String {
    func toTime() -> Int {
        let components = self.components(separatedBy: ":")
        let hours = Int(components[0])!
        let minutes = Int(components[1])!
        return hours * 60 + minutes
    }
}

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var dict: [String: Int] = [:]
    var sum: [String: Int] = [:]
    
    for _record in records {
        let record = _record.components(separatedBy: " ")
        let time = record[0].toTime()
        let id = record[1]
        
        if let inTime = dict[id] {
            let t = time - inTime
            sum[id, default: 0] += t
            dict.removeValue(forKey: id)
        } else {
            dict[id] = time
        }
    }
    
    for (id, inTime) in dict {
        sum[id, default: 0] += "23:59".toTime() - inTime
    }
    
    return sum.sorted(by: { a, b in a.key < b.key}).map { (_, time) in
        guard time > fees[0] else { return fees[1] }
        let _extraTime = Double(time - fees[0]) / Double(fees[2])
        let extraTime = Int(ceil(_extraTime))
        return fees[1] + extraTime * fees[3]       
    }
}