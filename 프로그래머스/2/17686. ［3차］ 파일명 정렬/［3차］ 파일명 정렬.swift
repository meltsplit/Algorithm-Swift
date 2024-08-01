struct FileName: Comparable {
    var rawValue: String
    
    var head: String
    var number: Int
    var tail: String
    
    init(_ rawValue: String) {
        
        self.rawValue = rawValue
        
        let value = rawValue.map { String($0).lowercased() }
        
        var firstIndexOfNumber: Int? = nil
        var lastIndexOfNumber: Int? = nil
        
        for i in value.indices {
            if firstIndexOfNumber == nil {
                if Int(value[i]) != nil {
                    firstIndexOfNumber = i
                    lastIndexOfNumber = i
                    continue
                } 
            } else {
                if Int(value[i]) != nil {
                lastIndexOfNumber = i
            } else {
                break
            }
            }
            
            
        }
        
        //aa1112aa34
        
        
        self.head = value[0..<firstIndexOfNumber!].joined()
        self.number = Int(value[firstIndexOfNumber!...lastIndexOfNumber!].joined())!
        self.tail = (lastIndexOfNumber! + 1) < value.count 
        ? value[(lastIndexOfNumber! + 1)...].joined()
        : ""
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.head == rhs.head else { return lhs.head < rhs.head }
        return lhs.number < rhs.number 
    }
}

func solution(_ files:[String]) -> [String] {
    return files.map { FileName($0) }.sorted().map { $0.rawValue }
}