import Foundation

func solution(_ citations:[Int]) -> Int {
    let c = citations.sorted(by: >).enumerated()
    for (i,c) in c {
        guard i+1 <= c else { return i }
    }
    return citations.count
}