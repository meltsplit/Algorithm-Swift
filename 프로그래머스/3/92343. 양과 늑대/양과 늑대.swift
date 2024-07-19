func solution(_ info:[Int], _ edges:[[Int]]) -> Int {
    
    var dict = [Int : [Int]]()
    for i in edges{
        if dict[i[0]] == nil{
            dict[i[0]] = [i[1]]
        }else{
            dict[i[0]]?.append(i[1])
        }
        
    }
    var result = 0
    func dfs(_ node: Int, _ nextNodes: [Int], _ sheep: Int, _ wolf: Int){
        var newNextNodes = nextNodes
        var sheepCnt = sheep
        var wolfCnt = wolf
        if info[node] == 0 {sheepCnt += 1}
        else {wolfCnt += 1}
        if wolfCnt >= sheepCnt{ return } //방문 할 수 있는 노드에서 현재노드를 지우지는 않고 리턴되게됨. 그래서 다음번에 리턴된 현재노드를 또 들리게되서 백트래킹이 완성.
        result = max(result, sheepCnt)
        
        newNextNodes.append(contentsOf: dict[node] ?? [])
        if let idx = newNextNodes.firstIndex(of: node){
            newNextNodes.remove(at: idx)
        }
        for i in newNextNodes{
            dfs(i, newNextNodes, sheepCnt, wolfCnt)
        }
    }
    dfs(0, [0], 0, 0)
    
    
    return result
}