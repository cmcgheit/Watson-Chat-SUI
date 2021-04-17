// Watson-Chat-SUI

import SwiftUI
import StreamChat

struct ChatView: View {
 
    @StateObject var listener: ChatChannelController.ObservableObject

    @State var message = ""

    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        
        let channel = listener.controller.channel!
        
        VStack {
            
            ScrollViewReader { reader in
                
                ScrollView(.vertical, showsIndicators: false, content: {
        
                    LazyVStack(alignment: .center, spacing: 15, content: {

                        ForEach(listener.messages.reversed(),id: \.self){ msg in
                            
                            // Message Row...
                            MessageRowView(messsage: msg)
                        }
                    })
                    .padding()
                    .padding(.bottom,10)
                    .id("MSG_VIEW")
                })
                .onChange(of: listener.messages, perform: { value in
                    
                    withAnimation{
                        reader.scrollTo("MSG_VIEW",anchor: .bottom)
                    }
                })
                .onAppear(perform: {
                    reader.scrollTo("MSG_VIEW",anchor: .bottom)
                })
            }
            
            HStack(spacing: 10){
                
                TextField("Message", text: $message)
                    .modifier(ShadowModifier())
                
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane.fill")
                        .padding(10)
                        .background(Color.primary)
                        .foregroundColor(scheme == .dark ? .black : .white)
                        .clipShape(Circle())
                })
                
                .disabled(message == "")
                .opacity(message == "" ? 0.5 : 1)
            }
            .padding(.horizontal)
            .padding(.bottom,8)
        }
        .navigationTitle(channel.cid.id)
    }
    
    func sendMessage(){
        
        
        let channelID = ChannelId(type: .messaging, id: listener.channel?.cid.id ?? "")
        
        ChatClient.shared.channelController(for: channelID).createNewMessage(text: message){result in
            
            switch result {
            
            case .success(let id):
                print("success = \(id)")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        message = ""
    }
}

