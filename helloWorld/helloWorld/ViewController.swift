//
//  ViewController.swift
//  helloWorld
//
//  Created by Mac on 03/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loadingImage: UIImageView!
    
    @IBOutlet weak var helloWorld: UIImageView!
    
    @IBOutlet weak var button2IMG: RoundedButton!
    

    
    override func viewWillAppear(_ animated: Bool) {
        button2IMG.isHidden = true
        loadingImage.isHidden = true
        helloWorld.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func button1Pressed(_ sender: Any) {
        loadingImage.isHidden = false
        button2IMG.isHidden = false
        print("button1 pressed")
    }
    @IBAction func displayHelloWorld(_ sender: Any) {
        helloWorld.isHidden = false
        print("button2 pressed")

    }
}




