import Foundation

// 1052
// return: 가장짧은 구간의 시작 진열대 번호, 끝 진열대 번호

func solution(_ gems:[String]) -> [Int] {
    var s = 0
    var e = 0
    var minDistance = Int.max
    var answer = [0, gems.count - 1]
    var dict = [String: Int]()
    var target = Set(gems).count
    
    dict[gems.first!] = 1
    
    while e < gems.count && s <= e {
        if dict.count == target {
            let distance = e - s + 1
            if distance < minDistance {
                minDistance = distance
                answer = [s, e]
            }
            s += 1
            
            let oldValue = gems[s - 1]
            dict[oldValue]! -= 1
            if dict[oldValue] == 0 { dict.removeValue(forKey: oldValue) }
        } else { // 미달 시 늘리기
            e += 1
            guard e < gems.count else { break }
            let newValue = gems[e]
            dict[newValue, default: 0] += 1
        }
    }
    
    return answer.map { $0 + 1 }
}