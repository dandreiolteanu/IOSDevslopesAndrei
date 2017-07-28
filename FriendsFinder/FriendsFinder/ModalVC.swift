//
//  ModalVC.swift
//  FriendsFinder
//
//  Created by Mac on 27/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import ALCameraViewController
import Firebase

class ModalVC: UIViewController {

    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var longLbl: UILabel!
    
    var currentCity1 = String()
    var currentCountry1 =  String()
    var currentAddress1 = String()
    var currentLatitude1 = String()
    var currentLongitude1 = String()
    var nameLblStr = String()
    
    // CAMERA
    
    var croppingEnabled: Bool = false
    var libraryEnabled: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("^^^^^^^^^^^^^^^^^",currentCountry,currentAddress)
        cityLbl.text = currentCity1
        countryLbl.text = currentCountry1
        streetLbl.text = currentAddress1
        currentLatitude1 = currentLatitude1 + "°"
        latLbl.text = currentLatitude1
        currentLongitude1 = currentLongitude1 + "°"
        longLbl.text = currentLongitude1
        
    }

    @IBAction func returnMainVC(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        
        let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { [weak self] image, asset in
//            self?.imageView.image = image
            
            let imageData = UIImageJPEGRepresentation(image!, 0.8)
            self?.uploadImageToFirebaseStorage(data: imageData! as NSData)

//            DispatchQueue.global(qos: .background).async {
//                do {
//                    let data = UIImageJPEGRepresentation(image!, 0.8)
//                    DispatchQueue.main.sync {
//                        
//                        self?.uploadImageToFirebaseStorage(data: data! as NSData)
//                    }
//                }
//            }
            
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
    }
    
    
    
    func randNumber() -> Int {
        
        let randNr = arc4random_uniform(1000) + 1
        return Int(randNr)
    }
    
    func uploadImageToFirebaseStorage(data: NSData) {
        
        let storageRef = Storage.storage().reference(withPath: "myPics/andrei\(randNumber()).jpg")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(data as Data, metadata: uploadMetadata) { (metadata, error) in
            if(error != nil) {
                print("Recieved an error")
            } else {
                print("Upload Complete ---> Metadata \(String(describing: metadata))")
            }
            
        }
    }
    
}

















