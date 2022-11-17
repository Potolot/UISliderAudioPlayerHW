//
//  ViewController.swift
//  UISliderHW7
//
//  Created by Вадим Воляс on 12.11.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var boyInDevyatka: UIButton!
    @IBOutlet weak var boyInDevyatkaImage: UIImageView!
    
    @IBOutlet weak var gorilaz: UIButton!
    @IBOutlet weak var gorilazImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func playMusicAction(_ sender: UIButton) {
        let playing = UIStoryboard(name: "Main", bundle: nil)
        guard let nextScreen = playing.instantiateViewController(withIdentifier: "PlayMusic") as? PlayViewController else { return }
        nextScreen.modalPresentationStyle = .automatic
        
        if sender.tag == 0 {
            choiseMusic(musicName: "9ka", player: &nextScreen.player)
            nextScreen.coverImageValue = boyInDevyatkaImage.image
            nextScreen.musicNameValue = boyInDevyatka.titleLabel?.text ?? ""
        } else {
            choiseMusic(musicName: "gorillaz", player: &nextScreen.player)
            nextScreen.coverImageValue = gorilazImage.image
            nextScreen.musicNameValue = gorilaz.titleLabel?.text ?? ""
        }
        nextScreen.countSong = sender.tag
        show(nextScreen, sender: nil)
    }
    
    
    
    func choiseMusic(musicName: String, player: inout AVAudioPlayer) {
        do {
            if let audioPath = Bundle.main.path(forResource: musicName, ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch {
            print("Error")
        }
        player.play()
    }
    
    //для перехода
    @IBAction func UnwindSegueToViewController(segue: UIStoryboardSegue){
        
    }

}


