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
import  UserNotifications


class MainVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var playButton: CircleButton!
    @IBOutlet weak var pulsatorLayer: UIView!
    
    let pulsator = Pulsator()

    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var settings = [String : Int]()
    
    @IBOutlet weak var recordButtonPressed: UIButton!
    
    var pathNSURL: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
        
        pulsatorLayer.layer.addSublayer(pulsator)
        pulsator.numPulse = 4
        pulsator.backgroundColor = UIColor(red:0.24, green:0.65, blue:0.73, alpha:1.0).cgColor
        pulsator.radius = 90.0
        
        // 1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification acces granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
        
        
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
          try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
              DispatchQueue.main.async {
                    if allowed {
                        print("Allow")
                    } else {
                        print("Dont Allow")
                    }
                }
            }
      } catch {
            print("failed to record!")
        }
        
        // Audio Settings
        
      settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        pathNSURL = self.directoryURL()
        
        
        
    }
    
    func directoryURL() -> NSURL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("andrei.m4a")
        print(soundURL!)
        return soundURL as NSURL?
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            audioRecorder = try AVAudioRecorder(url: pathNSURL as URL,
                                                settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            finishRecording(success: false)
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }

    func finishRecording(success: Bool) {
        audioRecorder.stop()
        if success {
            print(success)
        } else {
            audioRecorder = nil
            print("Somthing Wrong.")
        }
    }

    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
            
        }
        pulsator.stop()
        
        if let path = pathNSURL {
            
            do {
                print("***************************",path)
                let sound = try AVAudioPlayer(contentsOf: path as URL)
                self.audioPlayer = sound
                self.audioPlayer.delegate = self
            } catch {
                print("Error!!!!")
            }
            
            let recognizer = SFSpeechRecognizer()
            let request = SFSpeechURLRecognitionRequest(url: path as URL)
            recognizer?.recognitionTask(with: request) { (result, error) in
                
                if let error = error {
                    print("There was an error: \(error)")
                } else {
                    self.transcriptionTextField.text = result?.bestTranscription.formattedString
                }
            }
            
        }
        
        pathNSURL = self.directoryURL()
        print("NEW: ",pathNSURL)
        self.audioRecorder = nil
        
    }
    
    


    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        pulsator.stop()
        
        scheduleNotification(inSeconds: 15, completion: {succes in
            if succes {
                print("Succesfully scheduled notif")
            } else {
                print("Error scheduling notif")
            }
        })

    }
    

    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                if self.audioRecorder == nil {
                    
                    self.startRecording()
                } else {
                    self.finishRecording(success: true)
                }
            }
                
                
                
                //if let path = Bundle.main.url(forResource: "andrei1", withExtension: "m4a") {
                
            }
        }
  
    @IBAction func playBtnPressed(_ sender: Any) {
        
        //activitySpinner.isHidden = true
        //activitySpinner.startAnimating()
        scheduleNotification(inSeconds: 5, completion: {succes in
            if succes {
                print("Succesfully scheduled notif")
            } else {
                print("Error scheduling notif")
            }
        })
        
        requestSpeechAuth()
        pulsator.start()
    }

    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Succes: Bool) -> ()) {
        
        // Add an attachment
        let myImage = "bannerNotif"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "png") else {
            completion(false)
            return
        }
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "Friendly reminder"
        //notif.subtitle = "And we'll take care of the rest"
        notif.body = "Voices will learn much more if you interact with it, that's why I need to send you this notifications"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
    }









}



