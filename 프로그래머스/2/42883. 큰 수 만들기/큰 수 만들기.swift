import Foundation

func solution(_ number: String, _ k: Int) -> String {
    var stack: [Character] = []
    var k = k
    
    for char in number {
        while k > 0 && !stack.isEmpty && stack.last! < char {
            stack.removeLast()
            k -= 1
        }
        stack.append(char)
    }
    
    // 만약 제거하지 못한 k가 남아있다면 뒤에서부터 제거
    while k > 0 {
        stack.removeLast()
        k -= 1
    }
    
    return String(stack)
}
