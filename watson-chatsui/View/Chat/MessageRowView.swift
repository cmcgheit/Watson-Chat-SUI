//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

struct MessageRowView: View {
    
    var messsage: ChatMessage
    
    var body: some View {
        
        HStack{

            if messsage.isSentByCurrentUser {
                Spacer()
            }
            
            HStack(alignment: .bottom,spacing: 10) {
                
                if !messsage.isSentByCurrentUser{
                    UserView(message: messsage)
                        .offset(y: 10.0)
                }
                
                VStack(alignment: messsage.isSentByCurrentUser ? .trailing : .leading, spacing: 6, content: {
                    
                    Text(messsage.text)
                    
                    Text(messsage.createdAt,style: .time)
                        .font(.caption)
                })
                .padding([.horizontal,.top])
                .padding(.bottom,8)
     
                .background(messsage.isSentByCurrentUser ? Color.blue : Color.gray.opacity(0.4))
                .clipShape(ChatBubble(corners: messsage.isSentByCurrentUser ? [.topLeft,.topRight,.bottomLeft] : [.topLeft,.topRight,.bottomRight]))
                .foregroundColor(messsage.isSentByCurrentUser ? .white : .primary)
                .frame(width: UIScreen.main.bounds.width - 150,alignment: messsage.isSentByCurrentUser ? .trailing : .leading)
                

                if messsage.isSentByCurrentUser {
                    UserView(message: messsage)
                        .offset(y: 10.0)
                }
            }
            
            if !messsage.isSentByCurrentUser {
                Spacer()
            }
        }
    }
}

