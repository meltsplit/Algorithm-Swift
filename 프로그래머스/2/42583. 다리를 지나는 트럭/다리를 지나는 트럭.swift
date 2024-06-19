import Foundation

func solution(_ bridge_length:Int, _ weight:Int, _ truck_weights:[Int]) -> Int {
    var time = 0
    var wait = truck_weights
    var bridge: [(Int,Int)] = [] // weight, time
    
    while !wait.isEmpty {
        if !bridge.isEmpty && bridge[0].1 == bridge_length {
            bridge.removeFirst()
        }
        
        if wait[0] + bridge.reduce(0) { $0 + $1.0 } <= weight {
            bridge.append((wait.removeFirst(),0))
            
        } 
        
        for i in 0..<bridge.count {
            bridge[i].1 += 1
        }
        time += 1
    }
    
    return time + bridge_length
}