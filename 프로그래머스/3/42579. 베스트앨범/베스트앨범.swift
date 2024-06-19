import Foundation

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    
    var g_ids: [String: [Int]] = [:] // 장르에 속한 고유번호 집합
    var g_play: [String: Int] = [:]
    
    for (i, (g, p)) in zip(genres,plays).enumerated() {
        
        g_ids[g, default: []] += [i]
        g_play[g, default: 0] += p
    }
    
    let answer = g_ids.sorted { g_play[$0.key]! > g_play[$1.key]! } 
                      .map { $0.value.sorted { plays[$0] > plays[$1] }} 
                      .flatMap { $0[0..<min($0.count, 2)] }
    return answer
}