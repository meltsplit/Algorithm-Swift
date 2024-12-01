import Foundation

func solution(_ s: String) -> Bool {
    
    var stack: [String] = []
    let strs = s.map { String($0) }
    
    for str in strs {
        if str == "(" {
            stack.append(str)
        } else {
            guard let lastElement = stack.last 
            else { return false }
            if lastElement == "(" {
                stack.removeLast()
            } else {
                stack.append(str)
            }
        }
    }
    
    return stack.isEmpty
    
}