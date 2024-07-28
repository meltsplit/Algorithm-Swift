import Foundation

func solution(_ arr:[[Int]]) -> [Int] {
    var answer = [0,0]
    
    func combine(_ x: Int, _ y: Int, _ length: Int) {
        
        var flag = arr[x][y]
        var ableToCombine = true
        
        for i in x..<x + length {
            for j in y..<y + length {
                if arr[i][j] != flag {
                    ableToCombine = false
                }
            }
        }
        
        if ableToCombine {
            answer[flag] += 1
        } else {
            if length == 1 {
                answer[arr[x][y]] += 1
            } else {
                var nextLength = length / 2
                combine(x,y, nextLength)
                combine(x + nextLength,y, nextLength)
                combine(x, y + nextLength, nextLength)
                combine(x + nextLength, y + nextLength, nextLength)
            }
            
        } 
    }
    
    combine(0,0,arr.count)
    
    return answer
}