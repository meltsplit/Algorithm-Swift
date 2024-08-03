import Foundation

// 13:44

// order: 각 손님들이 주문한 단품메뉴들이 문자열 형식으로 담긴 배열
// course: 코스요리를 구성하는 단품메뉴들의 갯수가 담긴 배열

// solution: 새로 추가하게 될 코스요리의 메뉴 구성을 문자열 형태로 배열

// 문제
// 가장 많이 함께 주문한 단품메뉴들을 코스요리 메뉴로 구성
// 코스요리 메뉴는 최소 2가지 이상의 단품메뉴 
// 최소 2명 이상의 손님으로부터 주문된 단품메뉴 조합에 대해서만 코스요리 메뉴 후보에 포함


// Idea 1: 조합
// 두개이상 주문이 있는 메뉴: Set<String>
// Set의 combination 2, 3, 4
// 해당 조합이 두번 이상나왔다면 append
// answer.sorted()

func combinations(_ arr: [String], 
                  _ now: [String], 
                  _ index: Int, 
                  _ k: [Int],
                  _ result: inout [String]) {
        if k.contains(now.count) {
            result.append(now.joined())
        }
        
        for i in index..<arr.count {
            combinations(arr, now + [arr[i]], i + 1, k, &result)
        }
}   

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    
    var combi: [String: Int] = [:]
    
    orders.forEach {
        let orderedSingleMenus = $0.map { String($0) }
        var menuSet: [String] = []
        combinations(orderedSingleMenus, [], 0, course, &menuSet)
        menuSet.forEach { menu in
            let menu = String(menu.sorted())
            combi[menu, default: 0] += 1
        }
    }

    var answer = [String]()
    
    for c in course {
        var arr = combi.filter { $0.key.count == c }
        let max = arr.values.max()
        if max == 1 { continue }
        let able = arr.filter { $0.value == max }.keys
        answer.append(contentsOf: able)
    }
    
    
    return answer.sorted()
}

