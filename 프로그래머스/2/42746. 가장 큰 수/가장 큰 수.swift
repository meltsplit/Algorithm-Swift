import Foundation

func solution(_ numbers:[Int]) -> String {
    let answer = numbers.sorted { Int("\($0)\($1)")! >  Int("\($1)\($0)")! }
                  .reduce("") { $0 + String($1) }
    return answer.prefix(1) == "0" ? "0" : answer
}