import SwiftUI

struct ApertureView:View{
    @State var currentPhoto = ""
    @State var isShowPhotoResult:Bool = false
    @State var isClear:Bool = true
    @State var returnHome = false
    @State var returnPrevious = false
    @Binding var isIntroViewPresented2:Bool
    @Binding var clearState:[Bool]
    
    let aperture = ["f1.4", "f2.0", "f2.8", "f4.0", "f5.6", "f8", "f11", "f16"] //8개
    
    @State var apertureLevel:Int = 0 // range: 0 ~ 7
    @State var isShowPresent:Bool = false
    
    var body: some View{
        ZStack{
            VStack{
                Text("Rotate the dial to adjust the ")
                    .font(.system(size:40))
                + Text("aperture")
                    .font(.system(size:40))
                    .fontWeight(.bold)
                Text("for sharp focus on subjects like butterflies and cats.")
                    .font(.system(size:40))
                Text("Hint: F2.0")
                    .font(.title)
                    .foregroundStyle(.gray)
                ZStack{
                    ApertureObject(apertureLevel: $apertureLevel)
                    CameraView(currentPhoto: $currentPhoto, isShowPhotoResult: $isShowPhotoResult, focusAmount: .constant(0), shutterSpeedIndex: .constant(0), apertureLevel: $apertureLevel,isShowAperturePresent: $isShowPresent, isShowShutterSpeedPresent: .constant(false), timerIndex: .constant(0), ci: .constant(0))
                    if isShowPresent{
                        AperturePresentView(apertureLevel: $apertureLevel)
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
                        ApertureObject(apertureLevel: $apertureLevel).result
                            .animation(.easeInOut, value: isShowPhotoResult)
                            .onTapGesture{
                                isShowPhotoResult.toggle()
                                if apertureLevel == 1{
                                    isClear = false
                                    clearState[1] = !isClear
                                }
                            }
                        Text(apertureLevel == 1 ? "Clear!" : "Try again")
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
                IntroView(model: IntroViewData().step2, whatGame: .apeature, isIntroViewPretended: $isIntroViewPresented2, clearState: $clearState)
            })
            .fullScreenCover(isPresented: $returnHome, content: {
                ContentView(clearState: clearState)
            })
    }
}


struct AperturePresentView:View{
    @Binding var apertureLevel:Int
    
    var body: some View{
        HStack(spacing:0){
            ForEach(0..<ApertureView(isIntroViewPresented2: .constant(false), clearState: .constant([])).aperture.count) { i in
                ZStack{
                    Rectangle()
                        .foregroundColor(i == apertureLevel ? .black:.gray)
                        .frame(width: 70, height: 50)
                    Text("\(ApertureView(isIntroViewPresented2: .constant(false), clearState: .constant([])).aperture[i])")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ApertureObject:View{
    @Binding var apertureLevel:Int
    
    let images = ["Aperture1", "Aperture2","Aperture3","Aperture4","Aperture5","Aperture6","Aperture7","Aperture8"]
    
    
    
    @State var currentAperture:[[CGFloat]] = [ApertureData().f1,ApertureData().f2,ApertureData().f3,ApertureData().f4,ApertureData().f5,ApertureData().f6,ApertureData().f7,ApertureData().f8]
    
    
    
    
    var body: some View{
        ZStack{
            ForEach(0..<images.count){i in 
                Image(images[i])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 500)
                    .offset(x:-135,y: 80)
                    .blur(radius: currentAperture[apertureLevel][i])
            }
        }
    }
    
    var result: some View{
        ZStack{
            ForEach(0..<images.count){i in 
                Image(images[i])
                    .resizable()
                    .scaledToFit()
                    .frame(height: 800)
                    .blur(radius: currentAperture[apertureLevel][i])
            }
        }
        .border(Color.black, width: 30)
    }
}


