import Foundation


func solution(_ brown:Int, _ yellow:Int) -> [Int] {
    
    var width_height_sum = (brown + 4) / 2
    var browns: [[Int]] = []
    var yellows: [[Int]] = []
    
    for i in 1...width_height_sum / 2 {
        browns.append([width_height_sum-i, i])
    }
    
    for j in 1...Int(sqrt(Double(yellow))) {
        if yellow % j == 0 {
               yellows.append([yellow / j, j])
        }
    }
    
    
    for b in browns {
        for y in yellows {
            let width = b[0]
            let height = b[1]
            let inner_width = y[0]
            let inner_height = y[1]
            
            if width - 2 >= inner_width && height - 2 >= inner_height {
                return b
            }
        }
    }
    
    
    print(yellows)
    
    return []
}