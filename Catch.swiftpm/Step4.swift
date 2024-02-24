import SwiftUI
import Combine

struct IsoView:View{
    @State var currentPhoto = ""
    @State var isShowPhotoResult:Bool = false
    @State var isClear:Bool = true
    @State var returnHome = false
    @State var isMove = false
    @State var returnPrevious = false
    @Binding var isIntroViewPresented4:Bool
    @Binding var clearState:[Bool]
    let iso:[Double] = [100, 200, 400, 800, 1600, 3200, 6400, 12800, 25600]
    let images:[String] = ["iso1", "iso2", "iso3", "iso4", "iso5", "iso6", "iso7", "iso8", "iso9"]
    @State var isoLevel:Double=0
    
    @State var isShowPresent:Double = 0.0
    
    var body: some View{
        ZStack{
            VStack{
                Text("Slide to adjust the ")
                    .font(.system(size:40))
                + Text("ISO")
                    .font(.system(size:40))
                    .fontWeight(.bold)
                + Text(" and reveal hidden details in the dark,")
                    .font(.system(size:40))
                Text("like the gleam in a cat's eyes signaling you've found the perfect setting.")
                    .font(.system(size:40))
                Text("Hint: more than 3200")
                    .font(.title)
                    .foregroundStyle(.gray)
                ZStack{
                    ZStack{
                        IsoObjectView(imageNames:images,index: $isoLevel )
                        if isoLevel < 5{
                            Image("eye")
                                .resizable()
                                .scaledToFit()
                                .frame( height: 500)
                                .offset(x: -135, y: 80)
                        }
                    }
                    
                    CameraView(currentPhoto: $currentPhoto, isShowPhotoResult: $isShowPhotoResult, focusAmount: .constant(0), shutterSpeedIndex: .constant(0), apertureLevel: .constant(0),isShowAperturePresent: .constant(false), isShowShutterSpeedPresent: .constant(false), timerIndex: .constant(0), ci: .constant(0))
                    VStack{
                        IsoPresentView(isoLevel: $isoLevel)
                            .opacity(isShowPresent)
                        Slider(value: $isoLevel, in: 0...8, step: 1,onEditingChanged: { editing in
                            isMove = true
                            if !editing{
                                isShowPresent = 0.0
                            }
                        }).onReceive(Just(isoLevel), perform: { _ in
                            if isMove {
                                SoundPlayerClass.shared.playAudio(index: 1)
                            }
                        })
                        .frame(width: 620)
                        .animation(.easeInOut, value: isoLevel)
                        .onChange(of: isoLevel) { _ in
                            isShowPresent = 1.0
                        }
                    }.offset(x: -135 ,y: 250)
                    
                }.frame(height: 800)
                HStack{
                    PreviousButton(returnPrevious: $returnPrevious)
                        .padding()
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
                        ZStack{
                            Image(images[Int(isoLevel)])
                                .resizable()
                                .scaledToFit()
                                .border(Color.black, width: 30)
                                .frame(height: 800)
                                .animation(.easeInOut, value: isShowPhotoResult)
                                .onTapGesture{
                                    isShowPhotoResult.toggle()
                                    if Int(isoLevel) > 4{
                                        isClear = false
                                        clearState[3] = true
                                    }
                                }
                            if Int(isoLevel) < 5{
                                Image("eye")
                                    .resizable()
                                    .scaledToFit()
                                    .border(Color.black, width: 30)
                                    .frame(height: 800)
                                    .onTapGesture{
                                        isShowPhotoResult.toggle()
                                        if Int(isoLevel) > 4{
                                            isClear = false
                                            clearState[3] = true
                                        }
                                    }
                            }
                        }
                        Text(Int(isoLevel) > 4 ? "Clear!" : "Try again")
                            .font(.system(size: 45, weight: .semibold, design: .default))
                        Text("Tap to close")
                            .foregroundStyle(.gray)
                            .font(.title)
                            .padding()
                    }
                }
                
                
            }
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .fullScreenCover(isPresented: $returnPrevious, content: {
            IntroView(model: IntroViewData().step4, whatGame: .iso, isIntroViewPretended: $isIntroViewPresented4, clearState: $clearState)
        })
        .fullScreenCover(isPresented: $returnHome, content: {
            ContentView(clearState: clearState)
        })
        
        
    }
}


struct IsoPresentView:View{
    @Binding var isoLevel:Double
    
    var body: some View{
        HStack(spacing:0){
            ForEach(0..<IsoView(isIntroViewPresented4: .constant(false), clearState: .constant([])).iso.count) { i in
                ZStack{
                    Rectangle()
                        .foregroundColor(Double(i) == isoLevel ? .black:.gray)
                        .frame(width: 70, height: 50)
                    Text("\(IsoView(isIntroViewPresented4: .constant(false), clearState: .constant([])).iso[i].formatted())")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct IsoObjectView:View{
    var imageNames:[String]
    @Binding var index:Double
    
    var body: some View {
        ZStack {
            ForEach(0..<imageNames.count, id: \.self) { idx in
                Image(imageNames[idx])
                    .resizable()
                    .scaledToFit()
                    .frame( height: 500)
                    .offset(x: -135, y: 80)
                    .opacity(idx == Int(index) ? 1 : 0) // 현재 인덱스의 이미지만 표시
            }
        }
    }
}
