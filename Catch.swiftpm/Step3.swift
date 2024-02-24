import SwiftUI

struct ShutterSpeedView:View{
    @State var currentPhoto = ""
    @State var isShowPhotoResult:Bool = false
    @State var isClear:Bool = true
    @State var returnHome = false
    @State var returnPrevious = false
    @Binding var isIntroViewPresented3:Bool
    @Binding var clearState:[Bool]
    
    let shutterSpeed = ["1/2", "1/30", "1/60", "1/250", "1/500", "1/1000"]
    @State var shutterSpeedLevel = 0
    @State var isShowPresent:Bool = false
    
    @State var currenIndex = 0
    @State var ci = 0
    var body: some View{
        ZStack{
            VStack{
                Text("Use the plus & minus to fine-tune the ")
                    .font(.system(size:40))
                + Text("shutter speed,")
                    .font(.system(size:40))
                    .fontWeight(.bold)
                Text("ensuring no motion trail is left behind by the cat.")
                    .font(.system(size:40))
                Text("Hint: more than 1/500")
                    .font(.title)
                    .foregroundStyle(.gray)
                ZStack{
                    SSObject(currentIndex: $currenIndex)
                    CameraView(currentPhoto: $currentPhoto, isShowPhotoResult: $isShowPhotoResult, focusAmount: .constant(0), shutterSpeedIndex: $shutterSpeedLevel, apertureLevel: .constant(0),isShowAperturePresent: .constant(false), isShowShutterSpeedPresent: $isShowPresent, timerIndex: $currenIndex, ci: $ci) 
                    
                    if isShowPresent{
                        ShutterSpeedPresentView(shutterSpeedLevel: $shutterSpeedLevel)
                            .offset(x: -135 ,y: 250)
                    }
                }.frame(height: 800)
                HStack{
                    PreviousButton(returnPrevious: $returnPrevious)
                    Spacer()
                    NextButton(isClear: $isClear, returnHome: $returnHome)
                        .padding()
                        .disabled(isClear)
                }.frame(width: UIScreen.main.bounds.width * 0.7)
                
            }
            if isShowPhotoResult{
                ZStack{
                    Color.white
                        //.opacity(0.2)
                    VStack{
                        Image(ShutterSpeedData().ssImages[shutterSpeedLevel][ci])
                            .resizable()
                            .scaledToFit()
                            .border(Color.black, width: 30)
                            .frame(height: 800)
                            .animation(.easeInOut, value: isShowPhotoResult)
                            .onTapGesture{
                                isShowPhotoResult.toggle()
                                if shutterSpeedLevel > 3 {
                                    isClear = false
                                    clearState[2] = !isClear
                                }
                            }
                        Text(shutterSpeedLevel > 3 ? "Clear!" : "Try again")
                            .font(.system(size: 45, weight: .semibold, design: .default))
                        Text("Tap to close")
                            .foregroundStyle(.gray)
                            .font(.title)
                            .padding()
                    }
                }
                
                
            }
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .fullScreenCover(isPresented: $returnPrevious, content: {
                IntroView(model: IntroViewData().step3, whatGame: .shutterSpeed, isIntroViewPretended: $isIntroViewPresented3, clearState: $clearState)
            })
            .fullScreenCover(isPresented: $returnHome, content: {
                ContentView(clearState: clearState)
            })
        
    }
}



struct ShutterSpeedPresentView:View{
    @Binding var shutterSpeedLevel:Int
    
    var body: some View{
        HStack(spacing:0){
            ForEach(0..<ShutterSpeedView(isIntroViewPresented3: .constant(false), clearState: .constant([])).shutterSpeed.count) { i in
                ZStack{
                    Rectangle()
                        .foregroundColor(i == shutterSpeedLevel ? .black:.gray)
                        .frame(width: 70, height: 50)
                    Text("\(ShutterSpeedView(isIntroViewPresented3: .constant(false), clearState: .constant([])).shutterSpeed[i])")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct SSObject: View {
    let images = ["1:1000_1", "1:1000_2", "1:1000_3", "1:1000_4", "1:1000_5"]
    let timerInterval: TimeInterval = 0.2
    @Binding var currentIndex:Int
    
    var body: some View {
        VStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(height: 500)
                .offset(x: -135, y: 80)
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
