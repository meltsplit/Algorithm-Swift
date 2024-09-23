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
    func remove110() -> ([String], Int) {
        var stack = [String]()
        var arr = Array(self.map { String($0) }.reversed())
        var count = 0
        
        while !arr.isEmpty {
            stack.append(arr.removeLast())
            guard stack.count >= 3 else { continue }
            
            let last = stack.removeLast() 
            let secondLast = stack.removeLast() 
            let thirdLast = stack.removeLast()
            
            if thirdLast == "1"
            && secondLast == "1"
            && last == "0" {
                count += 1
            } else {
                stack.append(thirdLast)
                stack.append(secondLast)
                stack.append(last)
            }
            
        }
        return (stack, count)
    }
    
}

func insert110(_ _stack: [String], _ count: Int) -> String {
        var stack = _stack
        var result = [String]()
        while !stack.isEmpty {
            let last = stack.removeLast()
            guard last != "0" 
            else {
                for _ in 0..<count {
                    result.append(contentsOf: ["0", "1", "1"])
                }
                result.append(last)
                result.append(contentsOf: stack.reversed())
                break
            }
            
            result.append(last)
        }
        
        
        if result.count != _stack.count + count * 3 {
            for _ in 0..<count {
                result.append(contentsOf: ["0", "1", "1"])   
            }
        }
        
        return result.reversed().joined()
    }

func solution(_ s:[String]) -> [String] {
    return s.map {
        let (no110Arr, count) = $0.remove110()
        return insert110(no110Arr, count)
    } 
}