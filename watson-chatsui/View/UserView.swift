//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

struct UserView: View {
    
    var message: ChatMessage
    
    var body: some View {
        
        Circle()
            .fill(message.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
            .frame(width: 40, height: 40)
            .overlay(
     
                Text("\(String(message.author.id.first!))")
                    .fontWeight(.semibold)
                    .foregroundColor(message.isSentByCurrentUser ? .white : .primary)
            )
            .contextMenu(menuItems: {
                
                Text("\(message.author.id)")
                
                if message.author.isOnline{
                    Text("Status: Online")
                }
                else{
                    Text(message.author.lastActiveAt ?? Date(),style: .time)
                }
            })
    }
}
