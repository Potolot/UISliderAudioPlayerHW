//
//  PlayViewController.swift
//  UISliderHW7
//
//  Created by Вадим Воляс on 12.11.2022.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var plyaPauseButton: UIButton!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    var player = AVAudioPlayer()
    var coverImageValue: UIImage?
    var musicNameValue = ""
    var timer: Timer?
    var songNames = ["9ka", "gorillaz"]
    var countSong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicNameLabel.text = musicNameValue
        coverImage.image = coverImageValue
        plyaPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        //присвоение длинны песни нашему слайдеру
        currentTimeSlider.maximumValue = Float(player.duration)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime() {
        
        self.currentTimeSlider.value = Float(player.currentTime)
        
        let currenTime = player.currentTime
        let minutes = Int(currenTime / 60)
        let seconds = Int(currenTime.truncatingRemainder(dividingBy: 60))
        
        startTimeLabel.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        let diffTime =  player.duration - player.currentTime
        let difMinutes = Int(diffTime / 60)
        let difSeconds = Int(diffTime.truncatingRemainder(dividingBy: 60))
        endTimeLabel.text = NSString(format: "%02d:%02d", difMinutes, difSeconds) as String
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        player.stop()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        player.stop()
    }
    
    @IBAction func playPauseACtion(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            plyaPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            plyaPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
    }
    
    @IBAction func nextSongAction(_ sender: UIButton) {
        if countSong == 0 {
            countSong += 1
            coverImage.image = UIImage(named: "second.jpeg")
            musicNameLabel.text = "Feel good inc."
        } else {
            countSong = 0
            let extractedExpr = UIImage(named: "deadBlonde9ka.jpeg")
            coverImage.image = extractedExpr
            musicNameLabel.text = "Мальчик на девятке"
        }
        let audioPath = Bundle.main.path(forResource: songNames[countSong], ofType: "mp3")
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        self.player.play()
    }
    
    
    @IBAction func currentTimeSliderAction(_ sender: UISlider) {
        player.currentTime = TimeInterval(currentTimeSlider.value)
    }
    
    
    @IBAction func volumeSliderAction(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    
    @IBAction func soundOff(_ sender: UIButton) {
        player.volume = 0
        volumeSlider.value = 0
    }


    @IBAction func soundMax(_ sender: UIButton) {
        player.volume = 1.0
        volumeSlider.value = 1.0
    }
    
    //activityViewController
    @IBAction func shareAction(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [musicNameLabel.text ?? "nill"], applicationActivities: nil)
        present(activityController, animated: true)
    }
}
