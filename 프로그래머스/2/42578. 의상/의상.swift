import Foundation

func solution(_ clothes:[[String]]) -> Int {
    var dict: [String: [String]] = [:]
    
    for c in clothes {
        let cloth = c[0]
        let kind = c[1]
        dict[kind, default: []].append(cloth)
    }
    
    return dict.reduce(1) { $0 * ($1.value.count + 1) } - 1
}
