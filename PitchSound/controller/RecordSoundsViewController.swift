//
//  RecordSoundsViewController.swift
//  PitchSound
//
//  Created by Swifta on 1/25/18.
//  Copyright © 2018 Swifta. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var startRecordingBtn: UIButton!
    @IBOutlet weak var stopRecordingBtn: UIButton!
    @IBOutlet weak var startRecordingLbl: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    override func viewDidLoad() {
        super.viewDidLoad()
         stopRecordingBtn.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


 
    @IBAction func stopAudio(_ sender: Any) {
        print("stop recording button clicked")
        stopRecordingBtn.isEnabled = false
        startRecordingBtn.isEnabled = true
        startRecordingLbl.text = "Tap to record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       // print("Stopped recording");
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
               print("Unable to save")
        }

    }
    @IBAction func recordAudio(_ sender: Any) {
        print("start recording button clicked")
        startRecordingBtn.isEnabled = false
        stopRecordingBtn.isEnabled = true
        startRecordingLbl.text = "Recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
//        let filePath = URL(string: )
        //create an instance of AudioFile class
        let audioFile = AudioFile(filePath: pathArray.joined(separator: "/"));
        let filePath = URL(string: audioFile._filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
      
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioUrl
        }
    }
}

