//
//  Made with ❤ and ☕ 
//

import SwiftUI

struct CreateNewChannelView: View {
    
    @EnvironmentObject var streamData: ChatViewModel
    @Environment(\.colorScheme) var scheme
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15, content: {
            
            Text("Create New Channel")
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Channel Name", text: $streamData.channelName)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .modifier(ShadowModifier())
            
            // Button...
            Button(action: streamData.createChannel, label: {
                Text("Create Channel")
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.primary)
                    .foregroundColor(scheme == .dark ? .black : .white)
                    .cornerRadius(8)
            })
            .padding(.top,10)
            .disabled(streamData.channelName == "")
            .opacity(streamData.channelName == "" ? 0.5 : 1)
        })
        .padding()
        .background(scheme == .dark ? Color.black : Color.white)
        .cornerRadius(12)
        .padding(.horizontal,35)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.2).ignoresSafeArea().onTapGesture {
            streamData.channelName = ""
            withAnimation{streamData.createNewChannel.toggle()}
        })
    }
}

struct CreateNewChannelView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewChannelView()
    }
}

