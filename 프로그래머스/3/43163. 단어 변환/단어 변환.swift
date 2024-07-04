

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
        var words = words
        guard now != target else { 
            answers.append(count)
            return 
        }
        
        for word in words.filter { $0.canChangeByOne(now) } {
            words.remove(word)
            dfs(word, count + 1, words)
            words.insert(word)
        }
    
    }
    dfs(begin, 0, words)
    return answers.min() ?? 0
}