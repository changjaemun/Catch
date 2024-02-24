import SwiftUI
import AVFoundation


class bgmPlayer:ObservableObject{
    
    static let shared = bgmPlayer()
    private var soundPlayer:AVAudioPlayer?
    
    func playAudio(_ sound : String){
        guard let audioData = NSDataAsset(name: sound)?.data else {
            fatalError("Asset not found")
        }
        do {
            soundPlayer = try! AVAudioPlayer(data: audioData, fileTypeHint: "mp3")
            soundPlayer?.play()
        } catch{
            print("")
        }
    }
}

class shutterPlayer:ObservableObject{
    
    static let shared = shutterPlayer()
    private var soundPlayer:AVAudioPlayer?
    
    func playAudio(_ sound : String){
        guard let audioData = NSDataAsset(name: sound)?.data else {
            fatalError("Asset not found")
        }
        do {
            soundPlayer = try! AVAudioPlayer(data: audioData, fileTypeHint: "mp3")
            soundPlayer?.play()
        } catch{
            print("")
        }
    }
}


class SoundPlayerClass: ObservableObject {
    static let shared = SoundPlayerClass()
    private var soundPlayers: [AVAudioPlayer] = []
    
    init() {
        addPlayer(sound: "bgm")
        addPlayer(sound: "dial")
        addPlayer(sound: "focus")
        addPlayer(sound: "shutterfinal")
        addPlayer(sound: "stepSelect")
        addPlayer(sound: "Clear")
    }
    
    func addPlayer(sound: String) {
        guard let audioData = NSDataAsset(name: sound)?.data else {
            fatalError("Asset not found")
        }
        
        do {
            let player = try AVAudioPlayer(data: audioData, fileTypeHint: "mp3")
            soundPlayers.append(player)
        } catch {
            print("Error creating AVAudioPlayer: \(error)")
        }
    }
    
    func playAudio(index: Int = 0) {
        guard index < soundPlayers.count else {
            return
        }
        
        soundPlayers[index].play()
    }
}
