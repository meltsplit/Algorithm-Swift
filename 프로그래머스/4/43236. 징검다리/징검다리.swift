import Foundation 

// IDEA: 이분탐색
// isPossible 
// n번 제거로 최소간격 interval 을 만들수 있는가?

// interval = 최솟값중 가장 큰값
// FFFFFTTTTTTTT
func solution(_ distance: Int, _ rocks: [Int], _ n: Int) -> Int {
    var rocks = rocks.sorted() + [distance]
    
    var low = 0
    var high = distance + 1
    
    func isPossible(_ minInterval: Int) -> Bool {
        var count = 0 
        var prev = 0
        for rock in rocks {
            let interval = rock - prev
            if interval < minInterval {
                count += 1
            } else {
                prev = rock
            }
        }
        
        return count <= n
    }
    
    while low + 1 < high {
        let mid = (low + high) / 2
        if isPossible(mid) {
            low = mid
        } else {
            high = mid
        }
    }
    
    return low
}