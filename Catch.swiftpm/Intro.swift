import SwiftUI

enum Feature{
    case shutterAndAutoFocus
    case apeature
    case shutterSpeed
    case iso
}

struct IntroView:View{
    let model:IntroViewModel
    let layout = UIScreen.main.bounds
    
    @State private var isShowGame = false
    @State var whatGame:Feature
    @State var isDetailViewPresented = true
    @State var returnPrevious = false
    @Binding var isIntroViewPretended:Bool
    @Binding var clearState:[Bool]

    var body: some View{
        VStack{
            Text(model.title)
                .font(.system(size: 60, weight: .bold))
                .padding(50)
            HStack{
                Image(model.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 10)
                    .padding()
                Text(model.whatWeDo)
                    .font(.system(size: 32, weight: .regular))
                .lineSpacing(10)
                .padding(50)
            }
            HStack{
                PreviousButton(returnPrevious: $returnPrevious)
                Spacer()
                Button{
                    isShowGame.toggle()
                }label: {
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .foregroundColor(.green)
                            .cornerRadius(15)
                        Text("Next")
                            .foregroundStyle(Color.white)
                            .font(.title)
                    }
                }.fullScreenCover(isPresented: $isShowGame, content: {
                    //switch case 문으로 각 뷰 리턴
                    switch whatGame{
                    case .shutterAndAutoFocus:
                        ShutterAndAutoFocusView(isIntroViewPresented1: $isIntroViewPretended, clearState: $clearState)
                    case .apeature:
                        ApertureView(isIntroViewPresented2: $isIntroViewPretended, clearState: $clearState)
                    case .shutterSpeed:
                        ShutterSpeedView(isIntroViewPresented3: $isIntroViewPretended, clearState: $clearState)
                    case .iso:
                        IsoView(isIntroViewPresented4: $isIntroViewPretended, clearState: $clearState)
                    default:
                        Text("")
                    }
                }).fullScreenCover(isPresented: $returnPrevious, content: {
                    ContentView(clearState:clearState)
                })
                .padding(50)
            }
            
        }.frame(width: layout.width * 0.8)
        
    }
}

//#Preview(body: {
//    IntroView(model:IntroViewData().step4, whatGame: .iso, isIntroViewPretended: .constant(true))
//})
