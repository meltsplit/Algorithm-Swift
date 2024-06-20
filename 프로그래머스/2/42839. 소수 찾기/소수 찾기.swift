import Foundation

func permutation<T>(_ elements: [T]) -> [[T]] {
    var result = [[T]]()
    var visited = [Bool](repeating: false, count: elements.count)
    
    func permut(_ now: [T]) {
        
        result.append(now)
        
        for i in 0..<elements.count {
            if visited[i] == true { continue }
            visited[i] = true
            permut(now + [elements[i]])
            visited[i] = false
        }
    }
    permut([])
    return result
}

func isPrimeNumber(_ n: Int) -> Bool {
    if n < 2 {
        return false
    }
    for i in 2..<Int(sqrt(Double(n)) + 1) {
        if n % i == 0 { return false }
    }
    return true
}

func solution(_ numbers: String) -> Int {
    return  Set(
        permutation(numbers.map { String($0) })
                .map { Int($0.reduce("",+)) ?? -1 }
                .filter { isPrimeNumber($0) }
               )
                .count
}