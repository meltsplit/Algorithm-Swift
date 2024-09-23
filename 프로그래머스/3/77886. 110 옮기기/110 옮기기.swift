import Foundation

// 1722

// 조건: 110 을 추출하여 임의의 위치로 이동
// return: 주어진 조건을 만족하는 문자열 중 사전 순 가장 앞 문자열


// Idea 1: 세마디씩 끊어서 우선순위 정하기
// 고려사항: 임의로 변경 후에 110 이 다시 생길수 있음 // 재귀

// s: 1110
// v: 7, 6

// s: 100111100
// v: 4, 1, 3, 7, 7, 6, 4

// Idea 2: 110을 가장 뒤쪽으로 보낸다.반복 . 그 후 111이 있다면 가장 뒤로 보낸다.


extension String {
    func pullBack(_ a: String,_ b: String, _ c: String) -> String {
        var stack = [String]()
        var arr = Array(self.map { String($0) }.reversed())
        var count = 0
        
        while !arr.isEmpty {
            stack.append(arr.removeLast())
            guard stack.count >= 3 else { continue }
            
            let last = stack.removeLast() 
            let secondLast = stack.removeLast() 
            let thirdLast = stack.removeLast()
            
            if thirdLast == a
            && secondLast == b
            && last == c {
                count += 1
            } else {
                stack.append(thirdLast)
                stack.append(secondLast)
                stack.append(last)
            }
            
        }
        // print("count", count)
        // print("stack", stack)
        var finalResult = [String]()
        while !stack.isEmpty {
            let last = stack.removeLast()
            if last == "0" {
                for _ in 0..<count {
                    finalResult.append(c)
                    finalResult.append(b)
                    finalResult.append(a)
                    // print("0일때 포문")
                }
                finalResult.append(last)
                finalResult.append(contentsOf: stack.reversed())
                break
                
            }
            finalResult.append(last)
        }
        // print("finalResult", finalResult)
        
        if finalResult.count != self.count {
            for _ in 0..<count {
                    finalResult.append(c)
                    finalResult.append(b)
                    finalResult.append(a)
                }
        }
        // print("finalResult", finalResult)
        
        return finalResult.reversed().joined()
    }
}

func solution(_ s:[String]) -> [String] {
    return s.map {
        // print("---")
        return $0.pullBack("1", "1", "0")
    } 
}