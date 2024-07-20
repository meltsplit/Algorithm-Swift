import Foundation
// 최저 예상 택시요금

// 포인트
// 합승을 할 것인가 말 것인가
// 어려운 예시
// 합승을 하지 않는 것이 최적해로 보이지만, 실제로 합승을 할 때 비용이 절감되는 경우를 찾는 것

// IDEA1: 이분탐색으로 한다면
// 적은 요금으론 집에 갈수 없지 FFFFFFTTTTTTTTTTTTTTT 삥삥 돌아가면 무조건 갈 수 있어
// isPossible

// IDEA2: DP - 작은문제들이
// 해당 지점에서 A와 B 까지 가는 최소 거리
// 점화식: 

/// Idea 3: 다익스트라 최단 거리
// 1에서 S, A, B까지의 최단 거리
// 2에서 S, A, B까지의 최단 거리
// 3에서 S, A, B까지의 최단 거리
// S에서 S, A, B까지의 최단 거리

/// Idea 4: 플로이드 와샬
// Idea3 방식


func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    
    var graph: [[Int?]] = Array(repeating: Array(repeating: nil, count: n + 1), count: n + 1)
    for i in 1...n {
        graph[i][i] = 0
    }
    
    for fare in fares {
        let c = fare[0]
        let d = fare[1]
        let f = fare[2]
        graph[c][d] = f
        graph[d][c] = f
    }
    
    for i in 1...n {
        for j in 1...n {
            for k in 1...n {
                // i를 거쳐서 갈때 vs j->k 안거치고 갈 때
                guard let path1 = graph[j][i],
                let path2 = graph[i][k] else { continue}
                let path = path1 + path2
                guard let direct = graph[j][k] else { 
                    graph[j][k] = path
                    graph[k][j] = path
                    continue
                }
                let minDistance = min(direct, path)
                graph[j][k] = minDistance
                graph[k][j] = minDistance
                
            }
        }
    }
    var answer = Int.max
    
    for i in 1...n {
        guard let sDistance = graph[i][s] else { continue }
        guard let aDistance = graph[i][a] else { continue }
        guard let bDistance = graph[i][b] else { continue }
        answer = min(answer, sDistance + aDistance + bDistance)
    }
    
    return answer
}