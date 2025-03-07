import Foundation

// return
func solution(_ tickets:[[String]]) -> [String] {
    
    var graph: [String: [String]] = [:]
    var ticketDict: [[String]: Int] = [:]
    
    for ticket in tickets {
        graph[ticket[0], default: []].append(ticket[1])
        ticketDict[ticket, default: 0] += 1
    }
    
    for key in graph.keys {
        graph[key] = graph[key]!.sorted()
    }
    
    var answer = [String]()
    
    func dfs(_ now: String, _ path: [String])  {
        guard answer.isEmpty else { return }
        if path.count == tickets.count + 1 {
            answer = path
            return
        }
        
        var nexts = graph[now] ?? []
        nexts = nexts.filter { ticketDict[[now,$0]]! > 0 }
        
        for next in nexts {
            ticketDict[[now, next]]! -= 1
            dfs(next, path + [next])
            ticketDict[[now, next]]! += 1
            
        }
    }
    dfs("ICN", ["ICN"])
    return answer
}