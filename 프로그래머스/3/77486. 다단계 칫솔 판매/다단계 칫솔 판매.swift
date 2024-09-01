import Foundation

// 17:10

// enroll : 각 판매원의 이름 
// referral : 각 판매원을 다단계 조직에 참여시킨 다름 판매원. enroll을 초대한 사람 = referral
// seller: 판매량 집계 데이터의 판매원 이름s
// amount : 판매량 집계 데이터의 판매 수량s
// Return : 각 판매원이 득한 이익금

func solution(_ enroll:[String], 
              _ referral:[String], 
              _ seller:[String], 
              _ amount:[Int]) -> [Int] {
    
    var dict: [String: Int] = [:]
    var bossOf: [String: String] = [:]
    
    for i in enroll.indices {
        bossOf[enroll[i]] = referral[i]
    }
    
    func dfs(_ me: String, _ boss: String?, _ amount: Int) {
        guard let boss = boss else { return }
        guard amount > 0 else { return }
        let bossBenefit = amount * 1 / 10
        let myBenefit = amount - bossBenefit
        
        dict[me, default: 0] += myBenefit
        dfs(boss, bossOf[boss], bossBenefit)
    }
    
    for i in seller.indices {
        let s = seller[i]
        let a = amount[i]
        dfs(s, bossOf[s], a * 100)
    }
    
    return enroll.map { dict[$0] ?? 0 }
}