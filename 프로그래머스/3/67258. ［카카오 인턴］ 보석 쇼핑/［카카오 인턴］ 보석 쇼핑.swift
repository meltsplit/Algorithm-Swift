import Foundation

// 1052
// return: 가장짧은 구간의 시작 진열대 번호, 끝 진열대 번호

func solution(_ gems:[String]) -> [Int] {
    var count = Set(gems).count
    
    var low = 0
    var high = gems.count
    var mid: Int { (low + high) / 2}
    var answer = [Int:[Int]]()
    
    func isPossible(_ distance: Int) -> Bool {
        var p1 = 0
        var p2 = 0
        var bag: [String: Int] = [:]
        
        for i in 0..<distance {
            p2 = i
            let newValue = gems[p2]
            bag[newValue, default: 0] += 1
        }
        
        while true {
            // print(distance, p1, p2, bag)
             if bag.keys.count == count { 
                // print(bag.keys, count)
                answer[distance] = [p1 + 1, p2 + 1]
                return true
            }
            
            let oldValue = gems[p1]
            p1 += 1
            p2 += 1
            guard p2 < gems.count else { return false }
            let newValue = gems[p2]
            
            if bag[oldValue] == 1 {
                bag.removeValue(forKey: oldValue)
            } else {
                bag[oldValue]! -= 1
            }
            bag[newValue, default: 0] += 1
        }
        return false
    }
    
    while low + 1 < high {
        if isPossible(mid) {
            high = mid
        } else {
            low = mid 
        }
    }
    
    return answer[high] ?? [1, gems.count]
}