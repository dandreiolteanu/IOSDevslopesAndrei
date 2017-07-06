//
//  VideoVC.swift
//  LogangVlogs
//
//  Created by Mac on 06/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {

    @IBOutlet weak var webView : UIWebView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    private var _logangser: Logangs!
    
    var logangster: Logangs {
        get {
            return _logangser
        } set {
            _logangser = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = logangster.videoTitle
        viewsLbl.text = logangster.viewsNumber
        webView.loadHTMLString(logangster.videoURL, baseURL: nil)
    }



}
