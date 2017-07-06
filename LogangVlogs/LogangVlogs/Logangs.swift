//
//  Logangs.swift
//  LogangVlogs
//
//  Created by Mac on 06/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation
class Logangs {
    private var _imageURL: String!
    private var _videoURL: String!
    private var _videoTitle: String!
    private var _viewsNumber: String!
    
    //Getters
    var imageURL: String {
        return _imageURL
    }
    var videoURL: String {
        return _videoURL
    }
    var videoTitle: String {
        return _videoTitle
    }
    var viewsNumber: String {
        return _viewsNumber
    }
    
    //End getters
    
    init(imageURL: String, videoURL: String, videoTitle : String, viewsNumber: String) {
        
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
        _viewsNumber = viewsNumber
    
    }
}
