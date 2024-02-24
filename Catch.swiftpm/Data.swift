import SwiftUI


//#Preview{
//    IntroView(model: IntroViewData().step1, whatGame: .apeature, isIntroViewPretended: .constant(true))
//}


struct IntroViewModel{
    let title:String
    let whatWeDo:String
    let image:String
}

struct IntroViewData{
    let step1 = IntroViewModel(title: "Step1. Take a picture", whatWeDo: "Focus on the subject before capturing the moment.\n\nOnce in focus, press the shutter to take a picture.", image: "intro1")
    let step2 = IntroViewModel(title: "Step2. Aperture", whatWeDo: "The aperture refers to the lens's inner hole diameter.\n\nA change in aperture alters the size of this hole.\n\nThis allows more or less light into the camera, affecting the depth of field of your final image", image: "intro22")
    let step3 = IntroViewModel(title: "Step3. Shutter Speed", whatWeDo: "When the mirror flips and the shutter opens, light imprints on the sensor.\n\nShutter speed governs the duration of light exposure and the presence of motion trails", image: "intro33")
    let step4 = IntroViewModel(title: "Step4. ISO", whatWeDo: "The sensor's light capture is regulated by ISO.\n\nBoosting ISO heightens light sensitivity, enabling brighter photos in low light\nbut be mindful as higher ISO can introduce more digital noise.", image: "intro44")
}

struct ApertureData{
    let f1:[CGFloat] = [10,10,10,10,10,10,10,0]
    let f2:[CGFloat] = [10,10,10,10,10,10,0,0]
    let f3:[CGFloat] = [10,10,10,10,10,0,0,0]
    let f4:[CGFloat] = [10,10,10,10,0,0,0,0]
    let f5:[CGFloat] = [10,10,10,0,0,0,0,0]
    let f6:[CGFloat] = [10,10,0,0,0,0,0,0]
    let f7:[CGFloat] = [10,0,0,0,0,0,0,0]
    let f8:[CGFloat] = [0,0,0,0,0,0,0,0]
}

struct ShutterSpeedData{
    let ssImages:[[String]] = [["1:2_1","1:2_2","1:2_3","1:2_4","1:2_5"],["1:30_1","1:30_2","1:30_3","1:30_4","1:30_5"],["1:60_1","1:60_2","1:60_3","1:60_4","1:60_5"],["1:250_1","1:250_2","1:250_3","1:250_4","1:250_5"],["1:500_1","1:500_2","1:500_3","1:500_4","1:500_5"],["1:1000_1","1:1000_2","1:1000_3","1:1000_4","1:1000_5"]]

    let ss1:[String] = ["1:2_1","1:2_2","1:2_3","1:2_4","1:2_5"]
    let ss2:[String] = ["1:30_1","1:30_2","1:30_3","1:30_4","1:30_5"]
    let ss3:[String] = ["1:60_1","1:60_2","1:60_3","1:60_4","1:60_5"]
    let ss4:[String] = ["1:250_1","1:250_2","1:250_3","1:250_4","1:250_5"]
    let ss5:[String] = ["1:500_1","1:500_2","1:500_3","1:500_4","1:500_5"]
    let ss6:[String] = ["1:1000_1","1:1000_2","1:1000_3","1:1000_4","1:1000_5"]
}
