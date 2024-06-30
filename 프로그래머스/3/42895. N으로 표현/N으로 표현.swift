// 사칙 연산 정의
func add(_ x: Int, _ y: Int) -> Int {
    x + y
}

func substract(_ x: Int, _ y: Int) -> Int {
    x - y
}

func multiply(_ x: Int, _ y: Int) -> Int {
    x * y
}

func divide(_ x: Int, _ y: Int) -> Int {
    x / y
}

func solution(_ N:Int, _ number:Int) -> Int {
    // 두 집합에 있는 숫자들을 사칙연산한 값들을 구하는 함수
    func operateTwoSets(_ set1: Set<Int>, _ set2: Set<Int>, _ operation: (Int, Int) -> Int) -> Set<Int> {
        var result = Set<Int>()
        
        for x in set1 {
            for y in set2 {
                let number = operation(x, y)
                if number >= 1 && number <= 32000 {
                    result.insert(number)
                }
            }
        }
        
        return result
    }
    
    // 숫자 N을 n개 가지고 만들 수 있는 수를 구하는 함수
    func canMakeNumbers(_ n: Int) -> Set<Int> {
        var result = Set<Int>()
        let operations = [add, substract, multiply, divide]
        
        // 그냥 N을 n개 나열해서 쓴 수
        result.insert(Int(String(repeating: "\(N)", count: n))!)
        
        // 1일 때는 연산할 집합이 없으니까 리턴
        guard n != 1 else { return result }
        
        // set[1] ~ set[n - 1]에서 set[n - 1] ~ set[1]까지 집합을 각각 사칙연산한 결과를 result에 추가
        for i in 1...(n - 1) {
            for operation in operations {
                result = result.union(operateTwoSets(sets[i], sets[n - i], operation))
            }
        }
        return result
    }
    
    // sets[i] = i개의 N으로 만들 수 있는 수
    var sets = Array(repeating: Set<Int>(), count: 9)
    
    // 1 ~ 8개로 구할 수 있는 숫자들을 집합에 넣는다.
    for i in 1...8 {
        sets[i] = canMakeNumbers(i)
    }
    
    // number를 만들 수 있는 가장 적은 N을 찾는다
    for i in 1...8 {
        if sets[i].contains(number) {
            return i
        }
    }
    
    // 8개 이내의 N으로 number를 만들 수 없다면 -1을 리턴한다.
    return -1
}