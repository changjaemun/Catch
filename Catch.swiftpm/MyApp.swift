import SwiftUI

@main
struct MyApp: App {
    @State var isShowOnboardingView:Bool = true
    
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .fullScreenCover(isPresented: $isShowOnboardingView, content: {
                    OnboardingView(isShowOnboardingView: $isShowOnboardingView)
                })
            
        }
    }
}

