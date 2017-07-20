//
//  MainVC.swift
//  Voices
//
//  Created by Mac on 20/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import Speech
import AVFoundation
import Pulsator

class MainVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var playButton: CircleButton!
    @IBOutlet weak var pulsatorLayer: UIView!
    
    let pulsator = Pulsator()

    var audioPlayer: AVAudioPlayer!
    //var recordingSession: AVAudioSession!
    //var audioRecorder: AVAudioRecorder!
    var settings = [String : Int]()
    
    @IBOutlet weak var recordButtonPressed: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
        pulsatorLayer.layer.addSublayer(pulsator)
        pulsator.numPulse = 4
        pulsator.backgroundColor = UIColor(red:0.24, green:0.65, blue:0.73, alpha:1.0).cgColor
        pulsator.radius = 90.0
        
//        recordingSession = AVAudioSession.sharedInstance()
//        do {
//            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                        print("Allow")
//                    } else {
//                        print("Dont Allow")
//                    }
//                }
//            }
//        } catch {
//            print("failed to record!")
//        }
//        
//        // Audio Settings
//        
//        settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]

        
        
        
    }
    
//    func directoryURL() -> URL? {
//        let fileManager = FileManager.default
//        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentDirectory = urls[0] as NSURL
//        let soundURL = documentDirectory.appendingPathComponent("andrei.m4a")
//        print(soundURL)
//        return soundURL as URL?
//    }
//    
//    func startRecording() {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            audioRecorder = try AVAudioRecorder(url: self.directoryURL()! as URL,
//                                                settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.prepareToRecord()
//        } catch {
//            finishRecording(success: false)
//        }
//        do {
//            try audioSession.setActive(true)
//            audioRecorder.record()
//        } catch {
//        }
//    }
//
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        if success {
//            print(success)
//        } else {
//            audioRecorder = nil
//            print("Somthing Wrong.")
//        }
//    }
//    
////    @IBAction func click_AudioRecord(_ sender: AnyObject) {
////        if audioRecorder == nil {
////            self.btnAudioRecord.setTitle("Stop", for: UIControlState.normal)
////            self.btnAudioRecord.backgroundColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
////            self.startRecording()
////        } else {
////            self.btnAudioRecord.setTitle("Record", for: UIControlState.normal)
////            self.btnAudioRecord.backgroundColor = UIColor(red: 221.0/255.0, green: 27.0/255.0, blue: 50.0/255.0, alpha: 1.0)
////            self.finishRecording(success: true)
////        }
////    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
        pulsator.stop()
    }
    
    


    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        pulsator.stop()
    }
    

    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                
                
                
                // Handling the media file, maybe here we will handle our voice recording
                if let path = Bundle.main.url(forResource: "andrei1", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error!!!!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                    
                        if let error = error {
                                print("There was an error: \(error)")
                        } else {
                            self.transcriptionTextField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                }
            }
        }
        
    }
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = true
        activitySpinner.startAnimating()
        requestSpeechAuth()
        pulsator.start()
    }
    
    

    
}



