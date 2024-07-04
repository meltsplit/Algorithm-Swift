import Foundation

func solution(_ tickets: [[String]]) -> [String] {
    var graph: [String: [String]] = [:]
    
    // 그래프 구성
    for ticket in tickets {
        let from = ticket[0]
        let to = ticket[1]
        
        if graph[from] == nil {
            graph[from] = []
        }
        graph[from]?.append(to)
    }
    
    // 사전 순으로 정렬
    for key in graph.keys {
        graph[key]?.sort(by: >)
    }
    
    var stack: [String] = ["ICN"]
    var path: [String] = []
    
    while !stack.isEmpty {
        let top = stack.last!
        
        if let destinations = graph[top], !destinations.isEmpty {
            stack.append(destinations.last!)
            graph[top]?.removeLast()
        } else {
            path.append(stack.removeLast())
        }
    }
    
    return path.reversed()
}
