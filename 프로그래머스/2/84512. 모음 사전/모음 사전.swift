func solution(_ word:String) -> Int {
    var word = word.map { String($0) }
    var dict = ["A": 1, "E": 2, "I": 3, "O": 4, "U": 5]
    var nums = [781, 156, 31, 6, 1]
    var sum = 0

    for i in 0..<word.count {
        if let n = dict[word[i]] {
            sum += nums[i] * (n-1) + 1
        }
    }

    return sum
}
// 출처: https://developer-eddy403.tistory.com/131 [@EddiOS:티스토리]