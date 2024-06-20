import Foundation


func solution(_ sizes:[[Int]]) -> Int {
    var max_array: [Int] = [] 
    var min_array: [Int] = []
    
    for s in sizes {
        max_array.append(s.max()!)
        min_array.append(s.min()!)
    }
    
    return max_array.max()! * min_array.max()!
}