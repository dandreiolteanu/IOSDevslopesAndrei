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
import UserNotifications
import NVActivityIndicatorView

class MainVC: UIViewController, Blurring, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var transcriptionTextField: UITextView!
    @IBOutlet weak var playButton: CircleButton!
    @IBOutlet weak var pulsatorLayer: UIView!
    @IBOutlet weak var pulsatorLayer2: UIView!
    
    let pulsator = Pulsator()
    let pulsator2 = Pulsator()
    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var settings = [String : Int]()
    
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    var pathNSURL: NSURL!
    var sameText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The blur effect before wich dismisses after launching the app
        self.blurWithDuration(duration: 0)
        self.unblurWithDuration(duration: 1.5)
        

        transcriptionTextField.isEditable = false
        
        // Pulsator, the pulse effect from the recordButton
        pulsatorLayer.layer.addSublayer(pulsator)
        pulsatorLayer2.layer.addSublayer(pulsator2)
        
        pulsator.numPulse = 2
        pulsator2.numPulse = 9
        
        pulsator.backgroundColor = UIColor(red:0.24, green:0.65, blue:0.73, alpha:1.0).cgColor
        pulsator2.backgroundColor = UIColor(red:0.70, green:0.05, blue:0.05, alpha:1.0).cgColor
        
        pulsator.radius = 60.0
        pulsator2.radius = 80.0
        
        pulsator.start()
        
        // REQUEST PERMISSION for NOTIFICATIONS
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification acces granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
        
        
        // REQUEST PERMISSION for ACCESING MICROPHONE
        recordingSession = AVAudioSession.sharedInstance()
        do {
          try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        pulsator.stop()
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
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        pulsator2.stop()
        pulsator.start()
        
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
                    self.transcriptionTextField.text = "Didn't quite hear your voice, could you speak louder?"
                } else {
                    self.transcriptionTextField.text = result?.bestTranscription.formattedString
                }
            }
            
        }
        pathNSURL = self.directoryURL()
        print("NEW: ",pathNSURL)
        self.audioRecorder = nil
        
        // Scheduling the notification after we succesfully recorded a session
        scheduleNotification(inSeconds: 5, completion: {succes in
            if succes {
                print("Succesfully scheduled notif")
            } else {
                print("Error scheduling notif")
            }
        })

    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        pulsator2.stop()
        pulsator.start()
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
        }
    }
  
    @IBAction func playBtnPressed(_ sender: Any) {
        
        requestSpeechAuth()
        pulsator.stop()
        pulsator2.start()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
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
        
        notif.title = "Missed me?"
        //notif.subtitle = "And we'll take care of the rest"
        notif.body = "Voices will learn much more if you interact with it, that's why I need to send you this notifications."
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
