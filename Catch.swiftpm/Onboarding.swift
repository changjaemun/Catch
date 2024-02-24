import SwiftUI
import Combine

struct OnboardingView:View{
    @Binding var isShowOnboardingView:Bool
    
    var body: some View{
        TabView { 
            OnboardingViewFirstPage()
            OnboardingViewPage()
            OnboardingView3rdPage()
            OnboardingViewLastPage(isShowOnboardingView: $isShowOnboardingView)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingViewFirstPage:View{
    
    let layout = UIScreen.main.bounds
    let title:String = "Welcome to Catch!!"
    let sentence:String = "Discover the fundamentals of photography with Catch\nExplore the basics of cameras!"
    var body: some View{
        VStack{
            Text(title)
                .font(.system(size: layout.width * 0.07, weight: .bold, design: .default))
                
            Text(sentence)
                .font(.system(size: layout.width * 0.03, weight: .light, design: .default))
            .multilineTextAlignment(.center)
            .padding()
        }.frame(width: layout.width * 0.8)
        
         
    }
}

struct OnboardingViewPage:View{
    @State private var opacity1: Double = 1.0
    @State private var opacity2: Double = 0.0
    @State private var opacity3: Double = 0.0
    
    func timer(){
        let timerInterval: TimeInterval = 2
        
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            withAnimation(.linear(duration: 1)) {
                if opacity2 == 0.0 {
                    opacity2 = 1.0
                } else if opacity3 == 0.0 {
                    opacity3 = 1.0
                }
            }
        }
        
    }
    let layout = UIScreen.main.bounds
    let title:String = "We will take several steps to take good pictures of cats\nwith a lot of unexpected behavior"
    let images:[String] = [""]
    
    var body: some View{
        VStack{
            Text(title)
                .font(.system(size: layout.width * 0.03, weight: .light, design: .default))
                .multilineTextAlignment(.center)
//                .frame(height: UIScreen.main.bounds.height * 0.15)
            ZStack{
                Image("good1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 700)
                    .opacity(opacity1)
                Image("good2")
                .resizable()
                .scaledToFit()
                .frame(height: 700)
                .opacity(opacity2)
                Image("good3")
                .resizable()
                .scaledToFit()
                .frame(height: 700)
                .opacity(opacity3)
                .border(Color.black)
            }
        }.frame(width: layout.width * 0.8,height: layout.width * 0.8)
            .onAppear(perform: {
                timer()
            })
        
    }
}
struct OnboardingView3rdPage:View{
    
    let title:String = "This is the camera that we will be using.\nFeel free to manipulate it and Explore the features"
    let layout = UIScreen.main.bounds
    @State var slider:Double = 0
    @State var isMove = false
    var body: some View{
        VStack{
            Text(title)
                .font(.system(size: layout.width * 0.03, weight: .light, design: .default))
                .multilineTextAlignment(.center)
            ZStack{
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 800, height: 500)
                    .offset(x:-135, y:80)
                CameraView(currentPhoto: .constant(""), isShowPhotoResult: .constant(false), focusAmount: .constant(0), shutterSpeedIndex: .constant(0), apertureLevel: .constant(0),isShowAperturePresent: .constant(false),isShowShutterSpeedPresent: .constant(false), timerIndex: .constant(0), ci: .constant(0)) 
                Slider(value: $slider, in: 0...8, step: 1,onEditingChanged: { editing in
                    isMove = true
                    if !editing{
                        
                    }
                }).onReceive(Just(slider), perform: { _ in
                    if isMove{
                        SoundPlayerClass.shared.playAudio(index: 1)
                    }
                    
                })
                .frame(width: 620)
                .animation(.easeInOut, value: slider)
                .offset(x: -135 ,y: 250)
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.yellow)
                    .offset(x: 240,y: -350)
                    .shadow(radius: 10)
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.yellow)
                    .offset(x: 200,y: -100)
                    .shadow(radius: 10)
                Image(systemName: "arrowshape.right.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.yellow)
                    .offset(x: 200,y:100)
                    .shadow(radius: 10)
                Image(systemName: "arrowshape.down.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .foregroundColor(.yellow)
                    .offset(x: -420,y:150)
                    .shadow(radius: 10)
                }
            
            }.frame(width: layout.width * 0.8,height: layout.width * 0.8)
            
        }
        
    }


struct OnboardingViewLastPage:View{
    @Binding var isShowOnboardingView:Bool
    let title:String = "Let's Catch!"
    let layout = UIScreen.main.bounds
    var body: some View{
        VStack{
            Spacer()
            Text(title)
            .font(.system(size: layout.width * 0.1, weight: .bold, design: .default))
            Spacer()
            Text("Tap to close")
                .foregroundStyle(.gray)
                .font(.title)
        }.frame(height: layout.height * 0.7)
        .onTapGesture{
            isShowOnboardingView.toggle()
        }
        
    }
}

//#Preview(body: { 
//    OnboardingView(isShowOnboardingView: .constant(true))
//})
