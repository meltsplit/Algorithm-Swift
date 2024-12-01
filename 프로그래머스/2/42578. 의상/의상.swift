import Foundation

// 23:09
// return: 서로 다른 옷의 조합의 수



func solution(_ clothes:[[String]]) -> Int {
   var dict: [String: [String]] = [:]
    
    for cloth in clothes {
        let value = cloth[0]
        let key = cloth[1]
        dict[key, default: []].append(value)
    }
    
    return dict.values.map { $0.count + 1 }.reduce(1, *) - 1
}
