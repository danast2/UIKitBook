//
//  ViewController.swift
//  UISlider
//
//  Created by Даниил Асташов on 29.12.2024.
//

import UIKit
import AVFoundation 

class ViewController: UIViewController {
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    var player = AVAudioPlayer()
    let slider = UISlider()
    var updateTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 200, height: 23)
        self.slider.center = self.view.center
        self.slider.minimumValue = 0.0
        self.slider.maximumValue = 100.0
        self.view.addSubview(slider)
        self.slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        

        do{
            if let audioPath = Bundle.main.path(forResource: "audio", ofType: "mp3"){
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                self.slider.maximumValue = Float(player.duration)
            }
        }catch{
            print("error ept")
        }
        updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeTimer(sender:)), userInfo: nil, repeats: true)
    }
    
    @objc
    func changeTimer(sender: Timer){
        if self.player.isPlaying{
            self.slider.value = Float(player.currentTime)
        }
    }
    
    @objc
    func changeSlider(sender: UISlider){
        if sender == slider{
            self.player.currentTime = TimeInterval(sender.value)
        }
    }
    @IBAction func buttonPlay(_ sender: Any) {
        if self.player.isPlaying{
            self.player.pause()
            playButton.setTitle("Play", for: .normal)
        }else{
            self.player.play()
            playButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func volumeSliderChange(_ sender: Any) {
        self.player.volume = self.volumeSlider.value
    }
    
}

