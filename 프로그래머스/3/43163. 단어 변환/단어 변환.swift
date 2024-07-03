
import Foundation

extension String {
    func isPossibleChange(_ target: String) -> Bool {
        zip(Array(self), Array(target))
            .filter { $0 != $1 }
            .count == 1 ? true : false
    }
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    
    if !words.contains(target) { return 0 }
    
    var result: [Int] = []
    
    func dfs(_ begin: String, _ target: String, _ words: [String], _ count: Int){
        if begin == target {
            result.append(count)
            return
        }
        
        if words.isEmpty {
            result.append(0)
            return
        }
        
        let isPossible = words.map { return begin.isPossibleChange($0) }
        
        for (offset, result) in isPossible.enumerated() {
            if result {
                var tmp = words
                tmp.remove(at: offset)
                dfs(words[offset], target, tmp, count + 1)
            }
        }
    }

    dfs(begin, target, words, 0)

    return result.min()!
}