import SwiftUI
import StreamChat

class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    @AppStorage("username") var storedUser = ""
    @AppStorage("online_status") var logStatus = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let config = ChatClientConfig(apiKeyString: API_KEY)
        
        if logStatus{
            
            ChatClient.shared = ChatClient(config: config, tokenProvider: .development(userId: storedUser))
        }
        else {
            
            ChatClient.shared = ChatClient(config: config, tokenProvider: .anonymous)
        }
        
        return true
    }
}

