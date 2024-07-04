
// import Foundation

// extension String {
//     func isPossibleChange(_ target: String) -> Bool {
//         zip(Array(self), Array(target))
//             .filter { $0 != $1 }
//             .count == 1 ? true : false
//     }
// }

// func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
//     if !words.contains(target) { return 0 }
    
//     var result: [Int] = []
    
//     func dfs(_ begin: String, _ target: String, _ words: [String], _ count: Int){
//         if begin == target {
//             result.append(count)
//             return
//         }
        
//         if words.isEmpty {
//             result.append(0)
//             return
//         }
        
//         let isPossible = words.map { return begin.isPossibleChange($0) }
        
//         for (offset, result) in isPossible.enumerated() {
//             if result {
//                 var tmp = words
//                 tmp.remove(at: offset)
//                 dfs(words[offset], target, tmp, count + 1)
//             }
//         }
//     }

//     dfs(begin, target, words, 0)

//     return result.min()!
// }


import Foundation

extension String {
    func canChangeByOne(_ target: String) -> Bool {
        let numberOfDiff = zip(Array(self), Array(target))
        .filter { $0 != $1 }
        .count 
        return numberOfDiff == 1
    }
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    var words = Set(words)
    var answers: [Int] = []
    
    
    func dfs(_ now: String, _ count: Int, _ words: Set<String>) {
        print("now: \(now)")
        print("count: \(count)")
        var words = words
        guard now != target else { 
            answers.append(count)
            return 
        }
        
        print("now와 target은 다릅니다.")
        
        for word in words.filter { $0.canChangeByOne(now) } {
            words.remove(word)
            dfs(word, count + 1, words)
        }
    
    }
    dfs(begin, 0, words)
    return answers.min() ?? 0
// 1. Begin에 각자리를 바꾼다.
    // 만약 이미 같다면 바꾸지 않는다.
    // 다르다면 바꾸되 words에 있는 경우만 바꾼다.
   //
}