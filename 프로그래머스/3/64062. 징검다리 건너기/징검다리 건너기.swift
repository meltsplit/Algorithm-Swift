import Foundation

// 1644
// return 최대
// TTTFFF
func solution(_ stones:[Int], _ k:Int) -> Int {
    var low = 0
    var high = stones.max()! + 1
    var mid: Int { (low + high) / 2 }
    
    func f(_ x: Int) -> Bool {
        var length = 0
        
        for i in stones.indices {
            let isDrown = stones[i] - x + 1 <= 0
            length = isDrown ? length + 1 : 0
            guard length < k 
            else { return false }
        }
        return true
        
    }
    
    while low + 1 < high {
        if f(mid) {
            low = mid
        } else {
            high = mid
        }
    }
    
    return low
}