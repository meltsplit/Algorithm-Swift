// 16:07

// 음악 제목, 재생이 시작되고 끝난 시각, 악보
// 
// 음악은 반드시 처음부터 재생되며 음악 길이보다 재생된 시간이 길 때는 음악이 끊김 없이 처음부터 반복해서 재생된다. 
// 음악 길이보다 재생된 시간이 짧을 때는 처음부터 재생 시간만큼만 재생된다.
// 조건이 일치하는 음악이 없을 때에는 “(None)”을 반환한다.

extension String {
    func toSeconds() -> Int {
        let timeArr = self.split(separator: ":").map { Int($0)! }
        return timeArr[0] * 60 + timeArr[1]
    }
    
    func toMelody() -> String {
        var result: [String] = []
        for char in self {
            if char == "#" {
                result[result.endIndex - 1] = String(result.last!).lowercased()
            } else {
                result.append(String(char))
            }
        }
        return result.joined()
    }
}

struct Music {
    let startTime: String 
    let endTime: String
    let title: String 
    let melody: String
    
    init(_ infos: String) {
        let infos = infos.split(separator: ",").map { String($0) }
        self.startTime = infos[0]
        self.endTime = infos[1]
        self.title = infos[2]
        self.melody = infos[3].toMelody()
    }
    
    var timeInterval: Int {
        endTime.toSeconds() - startTime.toSeconds()
    }
    
    var playedMelody: String {
        let temp = timeInterval / melody.count + 1
        let myString = String(repeating: melody, count: temp)
        return String(myString.prefix(timeInterval))
    }
}

func solution(_ m: String, _ musicinfos: [String]) -> String {
    let target = m.toMelody()
    let musicInfos = musicinfos.map { Music($0) }
    let answer = musicInfos.filter { $0.playedMelody.contains(target) }
                            .sorted { $0.timeInterval > $1.timeInterval }
    return answer.first?.title ?? "(None)"
}