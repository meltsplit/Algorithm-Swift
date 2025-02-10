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
    
    var a = Set<Int>()
    var b = Set<Int>()
    
    var latestTurn = 0
    
    
    for i in 0..<(n / 3) {
        a.insert(cards[i])
    }
    print("maxTurn", (n / 3 + 1))
    for turn in 1...(n / 3 + 1) {
        latestTurn = turn
        guard turn < (n / 3 + 1) else { break }
        
        let newIndex1 = turn * 2 - 2 + n / 3 
        let newIndex2 = newIndex1 + 1
        let newValue1 = cards[newIndex1]
        let newValue2 = cards[newIndex2]
        b.insert(newValue1)
        b.insert(newValue2)
        
        if coin >= 0 {
            var success = false
            for card in a {
                let target = n + 1 - card 
                if a.contains(target) {
                    a.remove(card)
                    a.remove(target)
                    success = true
                    break
                }
            }
           
            if success {
                coin -= 0
                continue
            }
        }
        
        
        if coin >= 1 {
            var success = false
            for card in a {
                let target = n + 1 - card 
                if b.contains(target) {
                    a.remove(card)
                    b.remove(target)
                    success = true
                    break
                }
            }
           
            if success {
                coin -= 1
                continue
            } 
        } 
        
        if coin >= 2 {
            var success = false
            for card in b {
                let target = n + 1 - card 
                if b.contains(target) {
                    b.remove(card)
                    b.remove(target)
                    success = true
                    break
                }
            }
           
            if success {
                coin -= 2
                continue
            }
        } 
            
        break
    }
                  
    return latestTurn
}