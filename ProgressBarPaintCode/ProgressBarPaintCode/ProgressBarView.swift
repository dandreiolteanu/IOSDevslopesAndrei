//
//  ProgressBarView.swift
//  ProgressBarPaintCode
//
//  Created by Mac on 07/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {
    
    private var _inauntruProgress: CGFloat = 0.0
    
    var progress: CGFloat {
        set (newProgress) {
            if newProgress > 1.0 {
                _inauntruProgress = 1.0
            } else if newProgress < 0.0 {
                _inauntruProgress = 0.0
            } else {
                _inauntruProgress = newProgress
            }
            setNeedsDisplay()
        }
        get {
            return _inauntruProgress * bounds.width
        }
    }

    override func draw(_ rect: CGRect) {
        ProgressBarFun.drawProgressBar(frame: bounds, progress: progress)
    }

}
