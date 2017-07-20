//
//  Blurring.swift
//  BurgerFactory
//
//  Created by Mac on 20/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

protocol Blurring {}

extension Blurring where Self: UIViewController {
    func blurWithDuration(duration: TimeInterval) {
        let blurView = UIVisualEffectView(frame: view.bounds)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        
        UIView.animate(withDuration: duration) {
            blurView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    func unblurWithDuration(duration: TimeInterval) {
        guard let blurView = view.subviews.last as? UIVisualEffectView else { return }
        
        UIView.animate(withDuration: duration, animations: {
            blurView.effect = nil
        }, completion: { success in
            blurView.removeFromSuperview()
        })
    }
}
