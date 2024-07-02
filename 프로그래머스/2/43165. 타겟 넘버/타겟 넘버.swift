import Foundation


func solution(_ numbers:[Int], _ target:Int) -> Int {
    
    var answer = 0
    
    func dfs(_ index: Int, _ result: Int) {
        if index == numbers.count { 
            if result == target { answer += 1}
            return 
        }
        
        dfs(index + 1, result + numbers[index])
        dfs(index + 1, result - numbers[index])
    }
    
    dfs(0,0)
    
    
    return answer
}