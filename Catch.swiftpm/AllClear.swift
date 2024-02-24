import SwiftUI

struct AllClearView:View{
    @Binding var isClearAllSteps:Bool
    @Binding var clearState:[Bool]
    
    let layout = UIScreen.main.bounds
    
    var body: some View{
        VStack{
            Text("Congratulation!")
                .font(.system(size: layout.width * 0.07, weight: .bold, design: .default))
            .padding()
            Text("You've cleared all the steps")
            .font(.system(size: layout.width * 0.015, weight: .light, design: .default))
            .multilineTextAlignment(.center)
            .padding()
            Text("Now have fun taking pictures with your real camera")
                .font(.system(size: layout.width * 0.015, weight: .light, design: .default))
                .multilineTextAlignment(.center)
                
            Text("Tap to restart")
                .foregroundStyle(.gray)
                .font(.title)
                .padding()
        }.onTapGesture{
            isClearAllSteps = false
            clearState = [false,false,false,false]
        }
        
    }
}

#Preview(body: { 
    AllClearView(isClearAllSteps: .constant(true), clearState: .constant([]))
})
