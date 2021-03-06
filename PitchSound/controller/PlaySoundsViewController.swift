//
//  PlaySoundsViewController.swift
//  PitchSound
//
//  Created by Swifta on 1/29/18.
//  Copyright © 2018 Swifta. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        //REF: https://stackoverflow.com/questions/11346697/how-to-not-stretch-an-image-in-uibutton
        self.snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.vaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    }
    // MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
