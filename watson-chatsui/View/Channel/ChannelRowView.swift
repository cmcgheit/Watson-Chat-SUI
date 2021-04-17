//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

struct ChannelRowView: View {
    
    @StateObject var listener: ChatChannelController.ObservableObject
    
    @EnvironmentObject var streamData: ChatViewModel
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 5, content: {
            
            HStack(spacing: 12) {
                
                let channel = listener.controller.channel!
                
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 55, height: 55)
                    .overlay(
                        
                        Text("\(String(channel.cid.id.first!))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    )
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(channel.cid.id)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    if let lastMsg = channel.latestMessages.first {
                        
                        (
                            
                            Text(lastMsg.isSentByCurrentUser ? "Me: " : "\(lastMsg.author.id): ")
                                
                                +
                                
                                Text(lastMsg.text)
                        )
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        
                    }
                })
                
                Spacer(minLength: 10)
                
                // Time...
                if let time = channel.latestMessages.first?.createdAt{
                    Text(time,style: checkIsDateToday(date: time) ? .time : .date)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.leading,60)
        })
        .onAppear(perform: {
            listener.controller.synchronize()
        })
        .onChange(of: listener.controller.channel?.latestMessages.first?.text, perform: { value in
            // firing sort...
            print("sort channels...")
            sortChannels()
        })
    }

    func checkIsDateToday(date: Date)-> Bool {
        
        let calender = Calendar.current
        
        if calender.isDateInToday(date){
            return true
        }
        else{
            return false
        }
    }
    
    func sortChannels() {
        
        let result = streamData.channels.sorted { (ch1, ch2) -> Bool in
            
            if let date1 = ch1.channel?.latestMessages.first?.createdAt{
                
                if let date2 = ch2.channel?.latestMessages.first?.createdAt{
                    
                    return date1 > date2
                }
                else{
                    return false
                }
            }
            else{
                return false
            }
        }
        
        streamData.channels = result
    }
}
