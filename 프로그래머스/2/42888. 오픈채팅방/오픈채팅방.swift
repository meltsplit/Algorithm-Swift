import Foundation
//22 33

enum ChatType: String {
    case enter = "Enter"
    case leave = "Leave"
    case change = "Change"
    
    var result: String {
        switch self {
            case .enter: return "님이 들어왔습니다."
            case .leave: return "님이 나갔습니다."
            case .change: fatalError()
        }
    }
}

struct Chat {
    var type: ChatType
    var uid: String
    
    func toResult(_ name: String) -> String {
        name + type.result
    }
}

func solution(_ record:[String]) -> [String] {
    
    var chatList: [Chat] = []
    var nameDict: [String: String] = [:]
    
    for r in record {
        let data = r.split(separator: " ").map(String.init)
        var type = ChatType(rawValue: data.first!)!
        var uid = data[1]
        var nickname: String? = data.count > 2 ? data[2] : nil
        
        let chat = Chat(type: type, uid: uid)
        switch type {
            case .enter:
                nameDict[uid] = nickname!
                chatList.append(chat)
            case .leave:
                chatList.append(chat)
            case .change:
                nameDict[uid] = nickname!
        }
    }

    return chatList.map { chat in
        let name = nameDict[chat.uid]!
        return chat.toResult(name)
    }
}