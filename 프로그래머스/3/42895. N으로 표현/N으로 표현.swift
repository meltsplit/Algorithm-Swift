func solution(_ N:Int, _ number:Int) -> Int {
  
  var sets = Array(repeating: Set<Int>(), count: 9)

  //MARK: - 1
  // sets = F(n) (1<= n <= 8)를 설정한다.
  // F(n) = n개의 N로 만들 수 있는 수의 집합
  // F(n) = F(1) +-*/ F(n-1)
  
  func g(
    _ setX: Set<Int>,
    _ setY: Set<Int>,
    _ operation: (Int,Int) -> Int
  ) -> Set<Int> {
    var result = Set<Int>()
    for x in setX {
      for y in setY {
        let number = operation(x,y)
        if 1 <= number && number < 32000 {
          result.insert(number)
        }
      }
    }
    return result
    
  }
  func f(_ n: Int) -> Set<Int> {
    var result = Set<Int>()
    let oprations: [(Int,Int) -> Int] = [{ $0 + $1 },
                                         {$0 - $1},
                                         {$0 * $1},
                                         {$0 / $1}]
    result.insert(Int(String(repeating: "\(N)", count: n))!)
    
    guard n != 1 else { return result }
    
    // 점화식
    for i in 1...n-1 {
      for operation in oprations {
        let newSets = g(sets[i], sets[n-i], operation)
        result = result.union(newSets)
      }
      
    }
    return result
  }
  
  
  
  for n in 1...8 {
    sets[n] = f(n)
  }
  
  
  //MARK: - 2
  // number가 있는 지 확인한다. (작은 set부터)
  
  for n in 1...8 {
    if sets[n].contains(number) {
      return n
    }
  }
  
  return -1
  
}
