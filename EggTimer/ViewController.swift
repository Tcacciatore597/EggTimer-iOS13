//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes: [String : Float] = ["Soft": 3.0, "Medium": 4.0, "Hard": 7.0]
    var secondsRemaining: Float = 0.0
    var timer = Timer()
    var player: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        titleLabel.text = "How do you like your eggs?"
        timer.invalidate()
        self.progressBar.progress = 0.0
        guard let hardness = sender.currentTitle else { return }
        guard let eggTime = eggTimes[hardness] else { return }
        print(eggTime)
        
        secondsRemaining = eggTime
        let interval = 1/secondsRemaining
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { Timer in
            if self.secondsRemaining > 0 {
                print("\(self.secondsRemaining) seconds")
                self.progressBar.progress += interval
                self.secondsRemaining -= 1
            } else {
                Timer.invalidate()
                self.progressBar.progress = 1.0
                self.titleLabel.text = "Done!"
                self.playSound()
            }
        }
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
