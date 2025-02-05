import Foundation

// 1438
// return : 공평하게 자르는 방법의 수 

//        1 2 1 3 1 4 1 2
// left:  1 2 2 3 3 4 4 4
// right: 4 4 4 4 3 3 2 1

// | 1 | 2 | 3 | 

// dp
// f(x) = x에서 잘랐을 때 

func solution(_ topping:[Int]) -> Int {
    var leftBag = Set<Int>()
    var rightBag = Set<Int>()
    
    var leftArr = Array(repeating: -1, count: topping.count + 1)
    var rightArr = Array(repeating: -1, count: topping.count + 1)
    
    leftArr[0] = 0
    rightArr[topping.count] = 0
    
    for i in topping.indices {
        let j = topping.count - 1 - i
        
        leftBag.insert(topping[i])
        leftArr[i + 1] = leftBag.count
        
        rightBag.insert(topping[j])
        rightArr[j] = rightBag.count
    }
    
    return zip(leftArr, rightArr).filter { $0 == $1 }.count
}