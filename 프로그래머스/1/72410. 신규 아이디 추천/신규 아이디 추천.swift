import Foundation
// 20:00

// return: 7단계 후 추천아이디

func solution(_ new_id:String) -> String {
    var a = new_id.lowercased()
    a = a.filter { 
        $0.isLetter || $0.isNumber || ["-", "_", "."].contains($0)
    }
    
    var b = a.map { String($0) }
    b = b.enumerated().filter { (i , e) in
        guard i > 0 else { return true }
        return e != "." || (e == "." && b[i - 1] != ".")
    }.map { $1 }
    
    let firstIndex = b.firstIndex { $0 != "."}
    let lastIndex = b.lastIndex { $0 != "."}
    
    if let firstIndex = firstIndex, let lastIndex = lastIndex {
        b = Array(b[firstIndex...lastIndex])
    } else {
        b = ["a"]
    }
    
    b = Array(b.prefix(15))
    
    while !b.isEmpty {
        if b.last! == "." { 
            b.removeLast()
        } else {
            break
        }
    }
    
    while b.count <= 2  {
        b.append(b.last!)
    }
    return b.joined()
}