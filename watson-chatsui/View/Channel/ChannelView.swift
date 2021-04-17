//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

struct ChannelView: View {
    
    @EnvironmentObject var streamData: ChatViewModel
    
    var body: some View {
       
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 20) {
                
                if let channels = streamData.channels {
                    
                    ForEach(channels,id: \.channel){ listener in
                     
                        NavigationLink(
                            destination: ChatView(listener: listener),
                            label: {
                                
                                ChannelRowView(listener: listener)
                            })
                    }
                }
                else {
                    ProgressView()
                        .padding(.top,20)
                }
            }
            .padding()
        })
        .navigationTitle("Channels")
        
        .toolbar(content: {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    streamData.channels = nil
                    streamData.fetchAllChannels()
                }, label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    withAnimation{streamData.createNewChannel.toggle()}
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
            }
        })
        .onAppear(perform: {
            streamData.fetchAllChannels()
        })
    }
}

struct ChannelView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelView()
    }
}
