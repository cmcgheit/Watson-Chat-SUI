//
//  Made with ❤ and ☕ 
//

import SwiftUI

struct LoadingView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack{
            
            Color.primary
                .opacity(0.2)
                .ignoresSafeArea()
            
            ProgressView()
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .cornerRadius(8)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

