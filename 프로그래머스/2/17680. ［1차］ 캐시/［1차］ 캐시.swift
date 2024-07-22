import Foundation

func solution(
    _ cacheSize: Int, 
    _ cities: [String]
) -> Int {
    
    var queue: [String] = []
    var totalTime: Int = 0
    
    for city in cities {
        let city = city.lowercased()
        if queue.contains(city) {
            totalTime += 1
            queue.remove(at: queue.firstIndex(of: city)!)
            queue.append(city)
        } else {
            totalTime += 5
            queue.append(city)  
            if queue.count > cacheSize {
                queue.removeFirst()    
            } 
             
        }
    }
    
    return totalTime
}