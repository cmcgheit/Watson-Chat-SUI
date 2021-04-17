//
//  Made with ❤ and ☕ 
//

import SwiftUI
import StreamChat

@main
struct watson_chatsuiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
