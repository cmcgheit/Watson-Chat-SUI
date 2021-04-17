//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

class ChatViewModel: ObservableObject {
    
    @Published var username = ""
    @AppStorage("username") var storedUser = ""
    @AppStorage("online_status") var onlineStatus = false
    
    @Published var error = false
    @Published var errorMessage = ""
    
    @Published var isLoading = false
    @Published var channels: [ChatChannelController.ObservableObject]!
    
    @Published var createNewChannel = false
    @Published var channelName = ""
    
    func logInUser() {
        withAnimation{ isLoading = true }
        
        let config = ChatClientConfig(apiKeyString: API_KEY)
        
        ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: username))
        
        ChatClient.shared.currentUserController().reloadUserIfNeeded { error in
            withAnimation{ self.isLoading = false }
            
            
            if let error = error {
                self.errorMessage  = error.localizedDescription
                self.error.toggle()
                return
            }
            
            self.storedUser = self.username
            self.onlineStatus = true
        }
    }
    
    func fetchAllChannels() {
        
        if channels == nil {
            let filter = Filter<ChannelListFilterScope>.equal("type", to: "messaging")
            
            let request =  ChatClient.shared.channelListController(query: .init(filter: filter))
            
            request.synchronize { err in
                if let error = err{
                    self.errorMessage = error.localizedDescription
                    self.error.toggle()
                    return
                }
                
                self.channels = request.channels.compactMap({ (channel) -> ChatChannelController.ObservableObject? in
                    
                    return ChatClient.shared.channelController(for: channel.cid).observableObject
                })
            }
        }
    }
    
    
    func createChannel() {
        
        withAnimation{ self.isLoading = true }
        
        let normalizedChannelName = channelName.replacingOccurrences(of: " ", with: "-")
        
        let newChannel = ChannelId(type: .messaging, id: normalizedChannelName)

        let request = try! ChatClient.shared.channelController(createChannelWithId: newChannel, name: normalizedChannelName, imageURL: nil, extraData: .defaultValue)
        
        request.synchronize { err in
            
            withAnimation{self.isLoading = false}
            
            if let error = err {
                self.errorMessage = "Try to Create another channel, you can't use any special characters ($,'%, &, etc)\(error.localizedDescription)"
                self.error.toggle()
                return
            }
            
            self.channelName = ""
            withAnimation{ self.createNewChannel = false }
            self.channels = nil
            self.fetchAllChannels()
        }
    }
}
