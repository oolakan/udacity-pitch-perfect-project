//
//  AudioFile.swift
//  PitchSound
//
//  Created by Swifta on 1/30/18.
//  Copyright © 2018 Swifta. All rights reserved.
//

import Foundation

class AudioFile {
    var filePath: String
    
    var _filePath: String {
        get {
            return filePath
        }
    }
    init(filePath: String) {
        self.filePath = filePath
    }
}
