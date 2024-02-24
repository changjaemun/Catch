import SwiftUI
import AVFoundation


struct CameraView: View{
    @State private var isAnimating = false
    @State private var isLeftAnimating = false
    @State private var isRightAnimating = false
    
    @Binding var currentPhoto:String
    @Binding var isShowPhotoResult:Bool
    //1st game properties
    @Binding var focusAmount:CGFloat
    
    @Binding var shutterSpeedIndex:Int
    
    @Binding var apertureLevel:Int
    
    @Binding var isShowAperturePresent:Bool
    @Binding var isShowShutterSpeedPresent:Bool
    
    @Binding var timerIndex:Int
    @Binding var ci:Int
    
    let layout = UIScreen.main.bounds
    
    var body: some View{
        ZStack{
            Image("Camera")
                .resizable()
                .scaledToFit()
                .frame(height: 800)
            ShutterView(isAnimating: $isAnimating, isShowPhotoResult: $isShowPhotoResult, focusAmount: $focusAmount, currentIndex: $timerIndex, ci: $ci)
            
            PlusMinusView(isLeftAnimating: $isLeftAnimating, isRightAnimating: $isRightAnimating, shutterSpeedIndex: $shutterSpeedIndex, isShowPresent: $isShowShutterSpeedPresent)
            
            ApertureDialView(apertureLevel: $apertureLevel, isShowPresent: $isShowAperturePresent)
                .offset(x:385,y:170)
        }
    }
}

//#Preview(body: { 
//    CameraView(currentPhoto: .constant(""), isShowPhotoResult: .constant(false), focusAmount: .constant(0), shutterSpeedIndex: .constant(0), apertureLevel: .constant(0),isShowAperturePresent: .constant(false),isShowShutterSpeedPresent: .constant(false))
//})

struct ShutterView:View{
    @Binding var isAnimating:Bool // 카메라뷰
    @Binding var isShowPhotoResult:Bool
    @Binding var focusAmount:CGFloat
    
    @Binding var currentIndex:Int
    @Binding var ci:Int

    let layout = UIScreen.main.bounds
    
    func takePhoto(){
        withAnimation { 
            isShowPhotoResult.toggle()
        }
    }
    
    func focusOn(){
        let timerInterval: TimeInterval = 0.1
        
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            focusAmount -= 1
            if focusAmount < 0{
                SoundPlayerClass.shared.playAudio(index: 2)
                timer.invalidate()
            }
            
        }
        
    }
    
    var body: some View{
        Image("Shutter")
            .resizable()
            .scaleEffect(y: isAnimating ? 0.5 : 1.0, anchor: UnitPoint(x: 0, y: 1.35))
            .offset(x:390, y:-348)
            .frame(width: 190, height: isAnimating ? 70 : 100)
            .animation(.easeInOut(duration: 0.05), value: isAnimating)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        isAnimating = true // touch down
                    })
                    .onEnded({ _ in
                        isAnimating = false // touch up
                    })
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded({ _ in
                        focusOn()
                    })
            )
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        SoundPlayerClass.shared.playAudio(index: 3)
                        ci = currentIndex
                        takePhoto()
                    }
            )
        
    }
}

struct PlusMinusView:View{
    @Binding var isLeftAnimating:Bool
    @Binding var isRightAnimating:Bool
    @Binding var shutterSpeedIndex:Int
    @Binding var isShowPresent:Bool
    @State private var timer: Timer?
    let layout = UIScreen.main.bounds
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            isShowPresent = false
        }
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    var body: some View{
        HStack(spacing:0){
            Image("minus")
                .resizable()
                .scaledToFit()
                .frame(width:120, height:120)
                .scaleEffect(isLeftAnimating ? 0.8 : 1.0)
                .animation(.easeInOut, value: isLeftAnimating)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            isLeftAnimating = true // touch down
                            isShowPresent = true
                            resetTimer()
                            startTimer()
                            SoundPlayerClass.shared.playAudio(index: 1)
                        })
                        .onEnded({ _ in
                            isLeftAnimating = false // touch up
                            
                            if shutterSpeedIndex > 0{
                                shutterSpeedIndex -= 1
                            }
                        })
                )                
            Image("plus")
                .resizable()
                .scaledToFit()
                .frame(width:120, height:120)
                .scaleEffect(isRightAnimating ? 0.8 : 1.0)
                .animation(.easeInOut, value: isRightAnimating)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            isRightAnimating = true // touch down
                            isShowPresent = true
                            resetTimer()
                            startTimer()
                            SoundPlayerClass.shared.playAudio(index: 1)
                        })
                        .onEnded({ _ in
                            isRightAnimating = false // touch up
                            //resetTimer()
                            if shutterSpeedIndex < 5{
                                shutterSpeedIndex += 1                                    
                            }
                            
                        })
                )
        }.offset(x:385,y:-90)
    }
}

struct ApertureDialView: View {
    @State private var rotation: Double = 0.0
    @State private var rotation2: Int = 0
    @State private var index: Int = 0
    
    @Binding var apertureLevel:Int 
    {
        didSet{
            switch apertureLevel{
            case 0: SoundPlayerClass.shared.playAudio(index: 1)
            case 1: SoundPlayerClass.shared.playAudio(index: 1)
            case 2: SoundPlayerClass.shared.playAudio(index: 1)
            case 3: SoundPlayerClass.shared.playAudio(index: 1)
            case 4: SoundPlayerClass.shared.playAudio(index: 1)
            case 5: SoundPlayerClass.shared.playAudio(index: 1)
            case 6: SoundPlayerClass.shared.playAudio(index: 1)
            case 7: SoundPlayerClass.shared.playAudio(index: 1)
            default:
                return
            }
        }
    }
    @Binding var isShowPresent:Bool
    
    let layout = UIScreen.main.bounds
    
    
    var body: some View {
        VStack {
            Image("ApertureDial")
                .resizable()
                .scaledToFit()
                .frame(height:250)
                .rotationEffect(Angle(degrees: rotation))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            let center = CGPoint(x: 125, y: 125)
                            
                            let vector = CGVector(dx: value.location.x - center.x, dy: value.location.y - center.y)
                            
                            let radians = atan2(vector.dy - 50, vector.dx - 50)
                            
                            let degrees = radians * 180 / .pi
                            
                            rotation = Double(degrees)
                            rotation2 = Int((rotation + 225) / 45) % 8
                            apertureLevel = rotation2

                            isShowPresent = true
                        }
                        .onEnded{_ in 
                            isShowPresent.toggle()
                        }
                )
        }
    }
}
