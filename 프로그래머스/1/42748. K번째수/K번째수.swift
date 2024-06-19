import Foundation

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    return commands.map { command in
        let i = command[0] - 1
        let j = command[1] - 1
        let k = command[2] - 1
        return array[i...j].sorted()[k]
                        }
}