//import Foundation

// 1718
// 발판 상하좌우
// 패배: 움직일 곳 없을 때
// 같은 발판에 있을 때 상대가 먼저 움직이면 패배

// return 최적 플레이일 때, 두 캐릭터가 움직인 횟수의 합
struct Point {
    let x: Int
    let y: Int
}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}

class Node {
    let depth: Int
    var value = 0
    var selectedDepth = 0
    var childs = [Node]()
    
    init(_ depth: Int) {
        self.depth = depth
    }
    
    func update(_ isAturn: Bool) {
        if isAturn {
            // print("depth", depth, "value", value, "selectedDepth", selectedDepth)
            let selectedNode = childs.sorted(by: { $0.value > $1.value}).first
            value = selectedNode?.value ?? value
            selectedDepth = selectedNode?.selectedDepth ?? depth
        } else {
            // print("depth", depth, "value", value, "selectedDepth", selectedDepth)
            let selectedNode = childs.sorted(by: { $0.value < $1.value}).first
            value = selectedNode?.value ?? value
            selectedDepth = selectedNode?.selectedDepth ?? depth
        }
    }
    
}

func solution(_ board:[[Int]], _ aloc:[Int], _ bloc:[Int]) -> Int {
    var answer = 0
    let maxDepth = board.count * board[0].count - 2
    var visited = board.map { $0.map { $0 == 0 } }
    let aloc = Point(x: aloc[0], y: aloc[1])
    let bloc = Point(x: bloc[0], y: bloc[1])
    
    func isValid(_ point: Point) -> Bool {
        return point.x >= 0 && point.y >= 0 && point.x < board.count && point.y < board[0].count && !visited[point.x][point.y]
    }
    
    func dfs(_ isAturn: Bool, _ aloc: Point, _ bloc: Point, _ count: Int, _ me: Node) { 
        let now = isAturn ? aloc : bloc
        let dxs = [-1 , 1, 0, 0]
        let dys = [0, 0, -1, 1]     
        
        let nexts = zip(dxs, dys).compactMap { dx, dy -> Point? in
            let next = Point(x: now.x + dx, y: now.y + dy) 
            return isValid(next) ? next : nil
        }
    
        // print("isAturn", isAturn, "aloc", aloc, "bloc", bloc, "count", count, "nexts", nexts)
        guard !visited[now.x][now.y] && !nexts.isEmpty else {
            // print("isAturn", isAturn, "aloc", aloc, "bloc", bloc, "count", count, "nexts", nexts)
            var point = maxDepth - count
            point = isAturn ? -point : point
            me.value = point
            me.update(isAturn)
            return 
        }
        
        visited[now.x][now.y] = true
        
        for next in nexts {
            let nextAloc = isAturn ? next : aloc
            let nextBloc = isAturn ? bloc : next
            let node = Node(count + 1)
            me.childs.append(node)
            dfs(!isAturn, nextAloc, nextBloc, count + 1, node)
        }   
        
        visited[now.x][now.y] = false
        me.update(isAturn)
    }
    
    let node = Node(0)
    dfs(true, aloc, bloc, 0, node)
    
    return node.selectedDepth
    
}

