import Foundation

// n: 아파트 개수
// stations: 아파트 번호 배열 (오름차순 정렬, N보다 작거나 같음)
// w : 5g 전파 도달 거리
// RETURN: 기지국 개수의 최솟값

// Idea 0: Greedy
// 채워야 하는 아파트 = 이미 설치된 걸 뺀 아파트들
// 

func solution(_ n:Int, _ stations:[Int], _ w:Int) -> Int {
    
    var lastIndex = 0
    var answer = 0
    
    for station in stations {
        let startIndex = max(station - w, 1)
        let endIndex = min(station + w, n)
        
        guard startIndex > 1 else { 
            lastIndex = endIndex
            continue 
        }

        guard lastIndex < startIndex else {
            lastIndex = endIndex
            continue 
        }
        
        guard lastIndex <= n else {
            lastIndex = endIndex
            break
        }
        
        let count = startIndex - lastIndex - 1
        let newStationCount = Int(ceil(Double(count) / Double((w * 2 + 1))))
        answer += newStationCount
        lastIndex = endIndex
    }

    if lastIndex < n {
        var count = n - lastIndex
        let newStationCount = Int(ceil(Double(count) / Double((w * 2 + 1))))
        answer += newStationCount
    }
    
    return answer
    
}