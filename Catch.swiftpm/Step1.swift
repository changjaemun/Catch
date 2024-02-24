import SwiftUI

struct ShutterAndAutoFocusView: View{
    
    @State var focusAmount:CGFloat = 20
    @State var currentPhoto = ""
    @State var isShowPhotoResult:Bool = false
    @State var isClear:Bool = true
    @State var returnHome = false
    @State var returnPrevious = false
    
    @Binding var isIntroViewPresented1:Bool
    @Binding var clearState:[Bool]
    
    
    var body: some View{
        ZStack{
            VStack{
                Text("Long-press the ")
                    .font(.system(size:40))
                + Text("shutter")
                    .font(.system(size:40))
                    .fontWeight(.bold)
                + Text(" to focus.")
                    .font(.system(size:40))
                Text("Then tap it to take your photo.")
                    .font(.system(size:40))
                ZStack{
                    ZStack{
                    Object(focusAmount:$focusAmount)
                        if focusAmount < 0{
                            Image("focusOnSquare")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                                .offset(x:-135, y:80)
                        } else{
                            Image("focusSquare")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                                .offset(x:-135, y:80)
                        }
                    }

                    
                    CameraView(currentPhoto: $currentPhoto, isShowPhotoResult: $isShowPhotoResult, focusAmount: $focusAmount, shutterSpeedIndex: .constant(0), apertureLevel: .constant(0),isShowAperturePresent: .constant(false),isShowShutterSpeedPresent: .constant(false), timerIndex: .constant(0), ci: .constant(0))
                }.frame(height: 800)
                HStack{
                    PreviousButton(returnPrevious: $returnPrevious)
                    Spacer()
                    NextButton(isClear: $isClear, returnHome: $returnHome)
                        .padding()
                        .disabled(isClear)
                }.frame(width: UIScreen.main.bounds.width * 0.8)
            }
            
            if isShowPhotoResult{
                ZStack{
                    Color.white
                        //.opacity(0.2)
                    VStack{
                        ZStack{
                            Image("object1")
                                .resizable()
                                .scaledToFit()
                                .blur(radius: focusAmount)
                                .frame(height: 800)
                                .animation(.easeInOut, value: isShowPhotoResult)
                            Image("object1")
                                .resizable()
                                .scaledToFit()
                                .opacity(0)
                                .border(Color.black, width: 30)
                                .frame(height: 830)

                        }
                        
                        Text(focusAmount < 0 ? "Clear!" : "Try again")
                            .font(.system(size: 45, weight: .semibold, design: .default))
                        Text("Tap to close")
                            .foregroundStyle(.gray)
                            .font(.title)
                            .padding()
                    }.onTapGesture{
                        isShowPhotoResult.toggle()
                        if focusAmount < 0{
                            isClear = false
                            clearState[0] = !isClear
                        }
                    }
                }
                
            }
            
            
            
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .fullScreenCover(isPresented: $returnPrevious, content: {
                IntroView(model: IntroViewData().step1, whatGame: .shutterAndAutoFocus, isIntroViewPretended: $isIntroViewPresented1, clearState: $clearState)
            })
            .fullScreenCover(isPresented: $returnHome, content: {
                ContentView(clearState:clearState)
            })
            
            
            
        
    }
}

//#Preview(body: { 
//    ShutterAndAutoFocusView(isIntroViewPresented1: .constant(false))
//})

//struct Shutter:View{
//    var body: some View{
//        Rectangle()
//            .frame(width: 200, height: 120)
//            .offset(x:480, y:-420)
//            .opacity(0.01) // 0으로 만들 생각, 0으로 만들면 아예 사라짐
//        // 셔터 애니메이션 질문
//    }
//}

struct Object:View{
    let layout = UIScreen.main.bounds
    
    @Binding var focusAmount:CGFloat
    
    var body: some View{
        Image("object1")
            .resizable()
            .scaledToFit()
            .frame(height: 500)
            .offset(x:-135, y:80)
            .blur(radius: focusAmount)
    }
}

struct NextButton:View{
    @Binding var isClear:Bool
    @Binding var returnHome:Bool
    
    var body: some View{
        Button{
            returnHome.toggle()
        }label: {
            ZStack{
                Rectangle()
                    .frame(width: 200, height: 100)
                    .foregroundColor(isClear ? .gray:.green)
                    .cornerRadius(15)
                Text("Next")
                    .foregroundStyle(Color.white)
                    .font(.title)
            }
        }
    }
}

struct PreviousButton:View{
    @Binding var returnPrevious:Bool
    var body: some View{
        Button{
            returnPrevious.toggle()
        }label: {
            ZStack{
                Rectangle()
                    .frame(width: 200, height: 100)
                    .foregroundColor(.green)
                    .cornerRadius(15)
                Text("Prev")
                    .foregroundStyle(Color.white)
                    .font(.title)
            }
        }
    }
}
