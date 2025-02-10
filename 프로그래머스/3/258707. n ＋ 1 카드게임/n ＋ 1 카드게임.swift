import Foundation

// 16:08
// return: 도달 가능한 최대 라운드 수

// cards: 1~n
// coin개

// 1. 3/n,   카드, coin
// 2. 라운드 시작: 2장, 카드없으면 종료, 1coin = 카드 소유, 0coin = 카드 버림
// 3. 합이 n + 1 인 카드 2장 제출. else 게임 종료  

func solution(_ coin:Int, _ cards:[Int]) -> Int {
    let n = cards.count
    var coin = coin
    var dict: [Int: Int] = [:]
    
    for i in cards.indices {
        dict[cards[i]] = i 
    }
    
    var aCards = cards.map { dict[n + 1 - $0]!}
    var latestTurn = 0
    
    var memory = 0
    var cache = 0
    var storage = 0
    
    for i in 0..<(n / 3) {
        if aCards[i] <= i { memory += 1 } 
    }

    
    for turn in 1...(n / 3 + 1) {
        latestTurn = turn
        guard turn < (n / 3 + 1) else { break }
        let i = turn * 2 - 2 + n / 3
        let j = i + 1
        let iValue = aCards[i]
        let jValue = aCards[j]
        
        if iValue <= i { 
            if iValue < (n / 3) {
                cache += 1
            } else if iValue >= (n / 3) {
                storage += 1
                
            }
        }
        
        if jValue <= j {
            if jValue < (n / 3) {
                cache += 1
            } else if jValue >= (n / 3) {
                storage += 1
            }
        } 

        if memory > 0 && coin >= 0 {
            memory -= 1
            continue
        }
        
        
        if cache > 0 && coin >= 1 {
            cache -= 1
            coin -= 1
            continue
        } 
        
        if storage > 0 && coin >= 2 {
            storage -= 1
            coin -= 2 
            continue
        } 
            
        break
    }
                  
    return latestTurn
}