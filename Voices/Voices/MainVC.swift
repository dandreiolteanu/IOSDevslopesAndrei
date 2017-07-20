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
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordButton: UIButton!
    
    
    @IBOutlet weak var recordButtonPressed: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
        pulsatorLayer.layer.addSublayer(pulsator)
        pulsator.numPulse = 4
        pulsator.backgroundColor = UIColor(red:0.24, green:0.65, blue:0.73, alpha:1.0).cgColor
        pulsator.radius = 90.0
        
        recordingSession = AVAudioSession.sharedInstance()
        
        
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("andrei.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButtonPressed.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButtonPressed.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @IBAction func RecordButtonPressed(_ sender: Any) {
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordTapped()
                    } else {
                        print("Error")
                    }
                }
            }
        } catch {
            print("Error!!!")
        }

        
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
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
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

