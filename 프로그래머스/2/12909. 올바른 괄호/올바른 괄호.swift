import Foundation

func solution(_ s:String) -> Bool
{
    var s = s.map { String($0) }
    var stack = [String]()
    
    for ss in s {
        if stack.isEmpty || ss == "(" {
            stack.append(ss)
            continue
        }
        
        let top = stack.last!
        if top == "(" {
            stack.removeLast()
        } else {
            stack.append(top)
        }   
    }
    
    return stack.isEmpty
}