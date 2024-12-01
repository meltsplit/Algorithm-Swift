import Foundation

// 23:17
// return: 고유번호 순서대로 

struct Music {
    let id: Int
    let play: Int
}

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    
    var dict: [String: [Music]] = [:]
    var playDict: [String: Int] = [:]
    
    for i in genres.indices {
        let genre = genres[i]
        let play = plays[i]
        let music = Music(id: i, play: play)
        playDict[genre, default: 0] += play
        dict[genre, default: []].append(music)
    }
    
    var result: [Int] = []
    for (genre, _) in playDict.sorted { $0.value > $1.value} {
        guard let musics = dict[genre] else { continue }
        let top2 = musics.sorted { $0.play > $1.play }.map { $0.id }.prefix(2)
        result.append(contentsOf: top2)
    }
    return result
}