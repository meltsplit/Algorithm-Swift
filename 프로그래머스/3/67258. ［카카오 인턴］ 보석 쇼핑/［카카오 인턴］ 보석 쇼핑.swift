import Foundation

// 진열된 모든 종류의 보석을 적어도 1개 이상 포함하는 가장 짧은 구간 찾아서 구매

// games: 나열된 보석
// RETURN: 가장 짧은 구간의 시작과 끝

// Idea 1: 투포인터

// Idea 2: Set으로 자료구조 만들고 규칙 찾기

// Dia : 0, 3, 4, 7
// Ruby: 1, 2
// Em: 5
// Sap: 6

// Idea 3: 이분탐색
// isPossible(x): x구간이 possible한가? 

func solution(_ gems:[String]) -> [Int] {
    var gemsSet = Set(gems)
    let count = gemsSet.count
    var bag: [String: Int] = [:]
    for gem in gemsSet {
        bag[gem] = 0
    }
    
    var start: Int = 0
    var end: Int = 0
    var answer = [0, Int.max]
    print(count)
    bag[gems[0], default: 0] += 1
    var isFull = bag.values.allSatisfy { $0 > 0 }
    
    while start < gems.count && end < gems.count {
        
        if isFull { // 가방이 기준을 만족했다면
            if end - start < answer[1] - answer[0] {
                answer = [start + 1, end + 1]
            }
        }
        
        
        if !isFull { // 다 모으지 못했다면
            end += 1
            guard end < gems.count else { break }
            let count = bag[gems[end], default: 0]
            bag[gems[end]] = count + 1
            if count == 0 {
                isFull = bag.values.allSatisfy { $0 > 0 }
            }
            
            
        } else {
            let count = bag[gems[start], default: 0]
            if count <= 1 {
                bag[gems[start]] = 0
                isFull = false
            } else {
                bag[gems[start]] = count - 1
            }
            start += 1
        }
        
    }
    
    return answer
}

// "DIA", "RUBY", "RUBY", "DIA", "DIA", "EMERALD", "SAPPHIRE", "DIA"
