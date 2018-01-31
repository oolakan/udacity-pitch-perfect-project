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
// change record or stop button status when clicked
    fileprivate func changeButtonViewStatus(message: String, stopButtonStatus: Bool, startButtonStatus: Bool) {
        stopRecordingBtn.isEnabled = stopButtonStatus
        startRecordingBtn.isEnabled = startButtonStatus
        startRecordingLbl.text = message
    }
    
    @IBAction func stopAudio(_ sender: Any) {
        print("stop recording button clicked")
        let message = "Tap to record"
        changeButtonViewStatus(message: message, stopButtonStatus: false, startButtonStatus: true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Stopped recording");
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            let alertContrl = UIAlertController();
            alertContrl.title = "Error"
            alertContrl.message = "Unable to save"
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in self.dismiss(animated: true, completion: nil)}
            alertContrl.addAction(alertAction)
            self.present(alertContrl, animated: true, completion: nil)
        }

    }
    @IBAction func recordAudio(_ sender: Any) {
        print("start recording button clicked")
        let message = "Recording in progress"
        changeButtonViewStatus(message: message, stopButtonStatus: true, startButtonStatus: false)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
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

