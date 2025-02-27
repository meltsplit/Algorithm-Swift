import Foundation


// 1200
// return: 베스트 앨범에 들어갈 노래 고유 번호 순서대로

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    var playDict: [String: Int] = [:]
    var songDict: [String: [Int]] = [:]
    
    for i in genres.indices {
        let genre = genres[i]
        let play = plays[i]
        
        playDict[genre, default: 0] += play
        songDict[genre, default: []].append(i)
        songDict[genre]! = Array(songDict[genre]!.sorted { plays[$0] > plays[$1] }.prefix(2))
    }
    
    return playDict.sorted { $0.value > $1.value }.flatMap { songDict[$0.key] ?? [] }
}