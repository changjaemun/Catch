import SwiftUI

struct ContentView: View {
    @State private var isDetailViewPresented = false
    @State var isIntroViewPresented1 = false
    @State var isIntroViewPresented2 = false
    @State var isIntroViewPresented3 = false
    @State var isIntroViewPresented4 = false
    @State var test = false
    @State var isClearAllSteps = false
    
    // 메인화면
    @State var clearState:[Bool] = [false,false,false,false]
    
    var body: some View {
        VStack {
            Text("Catch")
                .font(.system(size:100, weight: .bold))
                .padding()
            RunningCat()
                .frame(width: 600, height: 600)
                .scaledToFit()
            HStack(spacing:100){
                VStack{
                    ZStack{
                        Image("step1")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:150, maxHeight: 150)
                            .shadow(radius: 5)
                            
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(.green)
                            .opacity(clearState[0] ? 1 : 0)
                            .scaledToFit()
                            .frame(maxWidth:150, maxHeight: 150)
                    }.onTapGesture {
                        isIntroViewPresented1.toggle()
                        SoundPlayerClass.shared.playAudio(index: 4)
                    }
                    .fullScreenCover(isPresented: $isIntroViewPresented1) {
                        // 이동할 다른 뷰
                        IntroView(model: IntroViewData().step1, whatGame: .shutterAndAutoFocus, isIntroViewPretended: $isIntroViewPresented1, clearState: $clearState)
                    }
                    Text("Step1")
                        .font(.system(size: 20, weight: .light, design: .default))
                    .padding()
                }
                VStack{
                    ZStack{
                        Image("step2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:150 , maxHeight: 150).shadow(radius: 5)
                            
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(.green)
                            .opacity(clearState[1] ? 1 : 0)
                            .scaledToFit()
                            .frame(maxWidth:150, maxHeight: 150)
                    }.onTapGesture{
                        isIntroViewPresented2.toggle()
                        SoundPlayerClass.shared.playAudio(index: 4)
                    }
                    .fullScreenCover(isPresented: $isIntroViewPresented2) {
                        // 이동할 다른 뷰
                        IntroView(model: IntroViewData().step2, whatGame: .apeature, isIntroViewPretended: $isIntroViewPresented2, clearState: $clearState)
                    }
                    
                    Text("Step2")
                        .font(.system(size: 20, weight: .light, design: .default))
                        .padding()
                }
                
                VStack{
                    ZStack{
                        Image("step3")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:150   , maxHeight: 150).shadow(radius: 5)
                            
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(.green)
                            .opacity(clearState[2] ? 1 : 0)
                            .scaledToFit()
                            .frame(maxWidth:150, maxHeight: 150)
                    }.onTapGesture{
                        isIntroViewPresented3.toggle()
                        SoundPlayerClass.shared.playAudio(index: 4)
                    }
                    .fullScreenCover(isPresented: $isIntroViewPresented3) {
                        // 이동할 다른 뷰
                        IntroView(model: IntroViewData().step3, whatGame: .shutterSpeed, isIntroViewPretended: $isIntroViewPresented3, clearState: $clearState)
                    }
                    Text("Step3")
                        .font(.system(size: 20, weight: .light, design: .default))
                    .padding()
                }
                VStack{
                    ZStack{
                        Image("step4")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:150   , maxHeight: 150).shadow(radius: 5)
                            
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(.green)
                            .opacity(clearState[3] ? 1 : 0)
                            .scaledToFit()
                            .frame(maxWidth:150, maxHeight: 150)
                    }.onTapGesture{
                        isIntroViewPresented4.toggle()
                        SoundPlayerClass.shared.playAudio(index: 4)
                    }
                    .fullScreenCover(isPresented: $isIntroViewPresented4) {
                        // 이동할 다른 뷰
                        IntroView(model: IntroViewData().step4, whatGame: .iso, isIntroViewPretended: $isIntroViewPresented4, clearState: $clearState)
                    }
                    Text("Step4")
                        .font(.system(size: 20, weight: .light, design: .default))
                    .padding()
                }
                
            }
        }.onAppear(perform: {
            SoundPlayerClass.shared.playAudio(index: 0)
            if !clearState.contains(false){
                isClearAllSteps = true
                SoundPlayerClass.shared.playAudio(index: 5)
            }
        })
        .environmentObject(SoundPlayerClass.shared)
        .fullScreenCover(isPresented: $isClearAllSteps, content: {
            AllClearView(isClearAllSteps: $isClearAllSteps, clearState: $clearState)
        })
        
    }
}

struct RunningCat: View {
    let images = ["running1","running2","running3","running4","running5","running6","running7","running8","running9","running10","running11","running12"]
    let timerInterval: TimeInterval = 0.07
    
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            Image(images[currentIndex])
                .resizable()
                .frame(width: 500, height: 500)
        }
        .onAppear {
            startImageCarousel()
        }
    }
    
    func startImageCarousel() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            currentIndex = (currentIndex + 1) % images.count
        }
    }
}
