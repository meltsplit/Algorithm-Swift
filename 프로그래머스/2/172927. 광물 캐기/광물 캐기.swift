import Foundation

let estimatedTime = [
    "diamond" : (1,5,25),
    "iron":  (1,1,5),
    "stone":  (1,1,1),   
]

func solution(
    _ picks:[Int], 
    _ minerals:[String]
) -> Int {
    
    var diaPick = picks[0]
    var ironPick = picks[1]
    var stonePick = picks[2]
    
    var buckets: [(Int,Int,Int)] = []
    var answer = 0
    
    var lastIndex = picks.reduce(0,+) * 5
    
    for index in minerals.indices {
        guard index < lastIndex else { break }
        
        let (withDia, withIron, withStone) = estimatedTime[minerals[index]]!
        
        if index % 5 == 0 {
            buckets.append((withDia, withIron, withStone))
        } else {
            buckets[index / 5].0 += withDia
            buckets[index / 5].1 += withIron
            buckets[index / 5].2 += withStone
        }
    }
    
    buckets = buckets.sorted { $0.2 > $1.2 }
    
    for bucket in buckets {
        if diaPick > 0 {
            answer += bucket.0
            diaPick -= 1
        } else if ironPick > 0 {
            answer += bucket.1
            ironPick -= 1
        } else  if stonePick > 0 {
            answer += bucket.2
            stonePick -= 1
        } 
    }
    
    return answer
}