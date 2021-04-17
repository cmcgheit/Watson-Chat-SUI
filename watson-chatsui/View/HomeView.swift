//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

struct HomeView: View {
    
    @StateObject var streamData = ChatViewModel()
    @AppStorage("online_status") var onlineStatus = false
    
    var body: some View {
        
        NavigationView {
            
            if !onlineStatus {
                LoginView()
                    .navigationTitle("Watson-Chat")
            }
            else {
                ChannelView()
            }
        }
        .alert(isPresented: $streamData.error, content: {
            
            Alert(title: Text(streamData.errorMessage))
        })
        .overlay(
            ZStack {
                if streamData.createNewChannel{CreateNewChannelView()}
            
                if streamData.isLoading{LoadingView()}
            }
        )
        .environmentObject(streamData)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
