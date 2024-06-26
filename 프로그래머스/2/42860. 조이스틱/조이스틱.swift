import Foundation

func solution(_ name: String) -> Int {
    let name = Array(name)
    let n = name.count
    
    var verticalSum = 0
    var horizontalSum = n - 1  // 오른쪽으로 쭉 갔을 때의 거리
    
    for (i,char) in name.enumerated() {
        // Vertical
        let diff = Int(char.asciiValue! - Character("A").asciiValue!)
        verticalSum += min(diff, 26 - diff)
        
        // 다음 'A'가 아닌 문자의 인덱스 찾기
        var next = i + 1
        while next < n && name[next] == "A" {
            next += 1
        }
        
        // 현재 위치에서 오른쪽으로 갔다가 다시 돌아오는 경우와
        // 왼쪽으로 갔다가 돌아오는 경우 중 최소 이동 수를 선택
        horizontalSum = min(horizontalSum, 
                            2 * i + name.count - next,
                            2 * (name.count - next) + i
                           )
    }
    
    return verticalSum + horizontalSum
}
