import Foundation

// 2118
// return: 경우의 수

// 문제 재정의
// 변을 정하기
// 변 선택 조건: 해당 변이 
// 한 변을 정하면 해당 변과 삼각형을 이루는 변은 선택할 수 없음

// Idea 1: DFS

// func solution(_ n:Int, _ tops:[Int]) -> Int {
    
//     // 그래프 구축
//     var graph: [Int: Set<Int>] = [:]

// Idea 2: DP
// 선행된 문제들의 memoization값이 후행 문제의 최적값이 됨.
// f(x) = x 번째 index까지 결정했을 때, 우측 찌르기 삼각형으로 끝나는 경우
// ㅎ(x) = x 번째 index까지 결정했을 때, 우측 찌르기 삼각형으로 끝나지 않는 경우

func solution(_ n:Int, _ tops:[Int]) -> Int {
    
    var f: [Int] = []
    var g: [Int] = []
    
    for i in tops.indices {
        let hasTop = tops[i] == 1
        
        guard i > 0 else {
            f.append(1)
            g.append(hasTop ? 3 : 2)
            continue
        }
        
        
        let f_co = hasTop ? 2 : 1
        let g_co = hasTop ? 3 : 2
        let nextF = f[i - 1] + g[i - 1]
        let nextG = f_co * f[i - 1] + g_co * g[i - 1]
        f.append(nextF % 10007)
        g.append(nextG % 10007)
    }
    
    return (f[n - 1] + g[n - 1]) % 10007
    
}