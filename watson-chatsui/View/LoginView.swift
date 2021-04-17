//Watson-Chat-SUI Coded with ♥️ by Carey M 

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var streamData: ChatViewModel
    
    // changing based on ColorScheme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            
            TextField("username", text: $streamData.username)
                .modifier(ShadowModifier())
                .padding(.top,20)
            
            Button(action: streamData.logInUser, label: {
                
                HStack{
                    
                    Spacer()
                    
                    Text("Login")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.primary)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .cornerRadius(5)
            })
            .padding(.top,20)
            .disabled(streamData.username == "")
            .opacity(streamData.username == "" ? 0.5 : 1)
            
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
