//
//  ViewController.swift
//  UISlider
//
//  Created by Даниил Асташов on 29.12.2024.
//

import UIKit
import AVFoundation 

class ViewController: UIViewController {
    var player = AVAudioPlayer()
    let slider = UISlider()
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
        self.player.play()
    }
    @objc
    func changeSlider(sender: UISlider){
        if sender == slider{
            self.player.currentTime = TimeInterval(sender.value)
        }
    }
    @IBAction func buttonPlay(_ sender: Any) {
        self.player.play()
    }
    
    @IBAction func buttonPause(_ sender: Any) {
        self.player.pause()
    }
    
}

