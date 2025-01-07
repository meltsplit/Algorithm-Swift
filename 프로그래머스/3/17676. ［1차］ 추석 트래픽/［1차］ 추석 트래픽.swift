// 1530

// return: 초당 최대 처리량
// 누적합

extension String {
    var toST: (Int, Int) {
        let components = self.split(separator: " ")
        
        let S = components[1]
        let T = components[2].filter { $0 != "s" }
        
        let hhmmss = S.split(separator: ".").first!
        let SSS = Int(S.split(separator: ".").last!)!
      
        let hh_mm_ss = hhmmss.split(separator: ":")
        
        let hh = Int(hh_mm_ss[0])!
        let mm = Int(hh_mm_ss[1])!
        let ss = Int(hh_mm_ss[2])!
        
        let totalSeconds = hh * 60 * 60 + mm * 60 + ss
        let s = totalSeconds * 1000 + SSS
          
        let T_ss = Int(T.split(separator: ".").first!)!
        let T_SSS = T.contains(".") ? Int(T.split(separator: ".").last!)! : 0
        let t = T_ss * 1000 + T_SSS
        return (s, t)  
    }
}

struct Node: Hashable {
    var start = 0
    var end = 0
}

func solution(_ lines:[String]) -> Int {
    var arr = Array(repeating: Node(), count: 24 * 60 * 60 * 1000 + 3000 + 1)
    
    // O(2000)
    for line in lines {
        let (S, T) = line.toST
        arr[S - (T - 1) + 3000].start += 1
        arr[S + 1 + 3000].end += 1
    }
    
    var result = Int.min
    var low = 0
    var high = 0
    var value = 0
    
    while high < arr.count {
 
        value += arr[high].start
        value -= arr[low].end

        if high >= 999 {
            low += 1
        }
        high += 1
        
        result = max(value, result)
    }
    
    return result
}