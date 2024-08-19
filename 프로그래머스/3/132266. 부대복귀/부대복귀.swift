// import Foundation

// // // n: 총 지역 수
// // // roads: 왕복할 수 있는 길 
// // // sources: 부대원 위치한 지역
// // // destination: 강철부대 지역
// // // RETURN: source의 원소 순서대로 강철부대로 복귀할 수 있는 최단 시간
// // // ㄴ 불가능한 경우 -1

// // // Idea 1: 유니온 파인드
// // // 거리를 구할 수 없음.

// // // 0 1 2 3 
// // // 0 0 0 0



// // func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination: Int) -> [Int] {
    
// //     var parents = (0...n).map { ($0,0) }
    
// //     func find(_ a: Int, _ depth: Int) -> (Int, Int) {
// //         guard parents[a].0 != a else { return (a, depth) }
// //         let tuple = find(parents[a].0, depth + 1)
// //         parents[a] = tuple
// //         return tuple
// //     }

// //     func union(_ a: Int, _ b: Int) {
// //         let parentOfA = parents[a].0
// //         let parentOfB = parents[b]
        
// //         if parentOfA < parentOfB {
// //             parents[parentOfB] = parentOfA
// //         } else {
// //             parents[parentOfA] = parentOfB
// //         }
// //     }
    
// //     for road in roads {
// //         union(road[0], road[1])
// //     }
    
// //     for parent in parents {
// //         find(parent, 0)
// //     }
    
// //     print(parents)
    
// //     return []
// // }

// // Idea 2: 플로이드 워셜
// func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination: Int) -> [Int] { 
    
//     var dp = Array(repeating: Array(repeating: Int.max / 2, count: n+1), count: n+1)
    
//     for i in 1...n {
//         dp[i][i] = 0
//     }
//     for road in roads {
//         let x = road[0]
//         let y = road[1]
//         dp[x][y] = 1
//         dp[y][x] = 1
//     }
    
//     for i in 1...n {
//         for k in 1...n {
//             for j in 1...n {
//                 dp[i][j] = min(dp[i][k] + dp[k][j], dp[i][j])
//             }
//         }
//     }
    
//     return sources.map { dp[$0][destination] != Int.max / 2 ? dp[$0][destination] : -1}
// }

// BFS
func solution(_ n:Int, _ roads:[[Int]], _ sources:[Int], _ destination:Int) -> [Int] {
    var graph = [Int: [Int]]()
    
    for road in roads {
        graph[road[0], default: []].append(road[1])
        graph[road[1], default: []].append(road[0])
    }
    
    var distance = Array(repeating: -1, count: n+1) // i 번째 지역에서 destination 까지의 최단 거리, 이 값은 destination에서 i번째 지역까지의 최단 거리로 생각 가능
    distance[destination] = 0
    
    bfs(departure: destination, graph: graph, distance: &distance)
    
    return sources.map { distance[$0] }
}

func bfs(departure: Int, graph: [Int: [Int]], distance: inout [Int]) {
    var queue = [Int]()
    queue.append(departure)
    
    while !queue.isEmpty {
        let cur = queue.removeFirst()
        let nextNodes = graph[cur, default: []]
        
        for node in nextNodes {
            if distance[node] != -1 { continue }
            distance[node] = distance[cur] + 1
            queue.append(node)
        }
    }
}