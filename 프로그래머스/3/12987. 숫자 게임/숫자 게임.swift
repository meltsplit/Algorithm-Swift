import Foundation

// B 팀원들이 얻을 수 있는 최대 승점을 return

// 먼저 모든 사원이 무작위로 자연수를 하나씩 부여받습니다.
// 각 사원은 딱 한 번씩 경기를 합니다.
// 각 경기당 A팀에서 한 사원이, B팀에서 한 사원이 나와 서로의 수를 공개합니다. 
// 그때 숫자가 큰 쪽이 승리하게 되고, 승리한 사원이 속한 팀은 승점을 1점 얻게 됩니다.

// 만약 숫자가 같다면 누구도 승점을 얻지 않습니다.

// Idea 1: 휴먼 알고리즘
// 질때 최대 격차로 지고
// 이길때 최소 격차로 이기자.

// sorted >
// sorted < 

// Idea 2: 이분탐색
// 최대 승점
// 0
// TTTTFFFFFF
// isPromise(): B가 A 를 n번 이길수 있는가?

func solution(_ a:[Int], _ b:[Int]) -> Int {
    var a = a.sorted()
    var b = b.sorted { $0 > $1 }
    var count = 0
        
    for aElement in a {
        while !b.isEmpty {
            let bElement = b.removeLast()
            if bElement > aElement {
                count += 1
                break
            }
        }
    }
    
    return count
}