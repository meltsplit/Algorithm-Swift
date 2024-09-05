func solution(_ scores:[[Int]]) -> Int {
    let target = scores[0] // 완호의 점수
    
    let attitudeScoreAscendingSorted = scores.sorted(by: { $0[0] > $1[0] || ($0[0] == $1[0] && $0[1] < $1[1]) })
    var maxPeerEvaluationScore = attitudeScoreAscendingSorted.first![1]
    
    var peopleCanGetIncentive = [[Int]]()
    
    for score in attitudeScoreAscendingSorted {
        if maxPeerEvaluationScore > score[1] {
            if score == target { return -1 }
            continue
        } else {
            peopleCanGetIncentive.append(score)
        }
        maxPeerEvaluationScore = max(maxPeerEvaluationScore, score[1])
    }
    
    let overallScore = peopleCanGetIncentive.map { $0[0] + $0[1] }.sorted(by: >)

    guard let ranking = overallScore.firstIndex(of: target.reduce(0, +)) else {
        return -1
    }
    
    return ranking + 1
}