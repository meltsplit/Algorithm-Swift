import Foundation

// 10%를 계산한 금액이 1 원 미만인 경우에는 이득을 분배하지 않고 자신이 모두 가집니다.

// enroll: 민호 제외 조직 구성원
// referral: enroll i 를 참여시킨 사람
// seller: 
// amount: 판매 집계 데이터


// 문제 정의
// - 
// 본질
// - 
// 재정의
// - 2
func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    var referralDict: [String: String] = [:]
    var dict: [String: Int] = [:]
    
    for i in referral.indices {
        let e = enroll[i] 
        let r = referral[i] == "-" ? "center" : referral[i]
        referralDict[e] = r
    }
    
    func dfs(_ person: String, _ profit: Int) {
        guard profit / 10 >= 1 else { 
            dict[person, default: 0] += profit
            return 
        } 
        dict[person, default: 0] += Int(ceil(Double(profit) * 0.9))

        if let referral = referralDict[person] {
            dfs(referral, profit / 10)
        }
    }
    
    for i in seller.indices {
        let s = seller[i]
        let profit = amount[i] * 100
        dfs(s, profit)
    }
    
    return enroll.map { dict[$0] ?? 0 }
}