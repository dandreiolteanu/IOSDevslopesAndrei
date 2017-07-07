//
//  ViewController.swift
//  ProgressBarPaintCode
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressBarView: ProgressBarView!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func sliderMoved(_ sender: Any) {
        progressBarView.progress = CGFloat(slider.value)
        
    }

  


}

