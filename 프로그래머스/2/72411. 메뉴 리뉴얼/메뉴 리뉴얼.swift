import Foundation

// 2020

// Idea 1:
// 모든 조합 = 

// Idea 2: dp
// f(x) =  x 번 나온 c개 묶음 조합
// return: 스카피가 추가할 메뉴 구성

func combination(_ elements: [String],  _ k: Int) -> [[String]] {
    var result = [[String]]()
    
    func combi(_ index: Int, _ now: [String]) {
        if now.count == k { 
            result.append(now)
            return
        }
        
        for i in index..<elements.count {
            combi(i + 1, now + [elements[i]])
        }
    }
    
    combi(0, [])
    return result
}

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    let orders = orders.map { Set($0.map { String($0)})  }
    var answer = [String]()
    var alpha = Set(orders.flatMap { $0.map { String($0) } })
    
    for c in course {
        var result = [Set<String>: Int]()

        for order in orders {
            let combis = combination(Array(order), c)
            for combi in combis {
                result[Set(combi), default: 0] += 1
            }
        }
        
        guard let maxValue = result.values.max(),
        maxValue >= 2 else { continue }
        
        
        for key in result.filter { $0.value == maxValue }.keys {
            answer.append(key.sorted().joined())
        }

    }
    
    
    return answer.sorted()
}